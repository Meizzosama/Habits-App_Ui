import 'package:flutter/material.dart';
import '../habits_screens/add-habitsList.dart';
import '../habits_screens/habitsList.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<HabitsListState> _habitsListKey =
      GlobalKey<HabitsListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Habits',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: HabitsList(key: _habitsListKey),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newHabit = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddHabitScreen(),
            ),
          );
          if (newHabit != null) {
            _habitsListKey.currentState?.addHabit(newHabit);
          }
        },
        backgroundColor: const Color.fromARGB(255, 72, 181, 205), 
        foregroundColor: const Color.fromARGB(255, 255, 255, 255), 
        elevation: 4.0, // Adding elevation
        tooltip: 'Add Habit',
        child: const Icon(Icons.add), // Tooltip
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/');
  }
}
