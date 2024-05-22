// ignore_for_file: use_super_parameters
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit-habitsList.dart';

class HabitsList extends StatefulWidget {
  const HabitsList({Key? key}) : super(key: key);

  @override
  HabitsListState createState() => HabitsListState();
}

class HabitsListState extends State<HabitsList> {
  late Map<String, bool> _habitsMap;

  @override
  void initState() {
    super.initState();
    _habitsMap = {};
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final List<String> habitKeys = prefs.getStringList('habits') ?? [];
      final List<String> doneValues = prefs.getStringList('done') ?? [];
      _habitsMap =
          Map.fromIterables(habitKeys, doneValues.map((e) => e == 'true'));
    });
  }

  Future<void> _saveHabit(String habit, bool done) async {
    final prefs = await SharedPreferences.getInstance();
    _habitsMap[habit] = done;
    _habitsMap = {
      habit: done,
      ..._habitsMap
    }; // Insert at the beginning of the map
    await prefs.setStringList('habits', _habitsMap.keys.toList());
    await prefs.setStringList(
        'done', _habitsMap.values.map((e) => e.toString()).toList());
  }

  Future<void> _deleteHabitFromPrefs(String habit) async {
    final prefs = await SharedPreferences.getInstance();
    _habitsMap.remove(habit);
    await prefs.setStringList('habits', _habitsMap.keys.toList());
    await prefs.setStringList(
        'done', _habitsMap.values.map((e) => e.toString()).toList());
  }

  Future<void> _editHabitInPrefs(String habit, String newHabit) async {
    final prefs = await SharedPreferences.getInstance();
    final done = _habitsMap.remove(habit);
    _habitsMap[newHabit] = done!;
    await prefs.setStringList('habits', _habitsMap.keys.toList());
  }

  Future<void> _toggleDoneInPrefs(String habit) async {
    final prefs = await SharedPreferences.getInstance();
    _habitsMap[habit] = !_habitsMap[habit]!;
    await prefs.setStringList(
        'done', _habitsMap.values.map((e) => e.toString()).toList());
  }

  void addHabit(String habit) {
    setState(() {
      _saveHabit(habit, false);
    });
  }

  void _deleteHabit(String habit) {
    setState(() {
      _deleteHabitFromPrefs(habit);
    });
  }

  void _editHabit(String habit, String newHabit) {
    setState(() {
      final done = _habitsMap[habit]!;
      _editHabitInPrefs(habit, newHabit);
      _habitsMap.remove(habit);
      _habitsMap = {newHabit: done, ..._habitsMap};
    });
  }

  void _toggleDone(String habit) {
    setState(() {
      _toggleDoneInPrefs(habit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _habitsMap.length,
      itemBuilder: (context, index) {
        final habit = _habitsMap.keys.elementAt(index);
        final done = _habitsMap[habit]!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: done ? Colors.green[100] : Colors.white,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              title: Text(
                habit,
                style: TextStyle(
                  fontFamily: GoogleFonts.badScript().fontFamily,
                  decoration: done ? TextDecoration.lineThrough : null,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  done ? Icons.check_circle : Icons.circle_outlined,
                  color: done
                      ? const Color.fromARGB(255, 127, 210, 130)
                      : Colors.grey,
                ),
                onPressed: () => _toggleDone(habit),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.teal.shade300),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditHabitScreen(
                            habit: habit,
                            onSave: (newHabit) => _editHabit(habit, newHabit),
                            index: habit.length,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.teal.shade300),
                    onPressed: () => _deleteHabit(habit),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
