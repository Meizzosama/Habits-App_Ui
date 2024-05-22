import 'package:flutter/material.dart';

class EditHabitScreen extends StatelessWidget {
  final int index;
  final String habit;
  final ValueChanged<String> onSave;

  const EditHabitScreen({
    required this.index,
    required this.habit,
    required this.onSave,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: habit);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Habit'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  onSave(controller.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
