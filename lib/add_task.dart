import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<AddTaskScreen> {
  final key = GlobalKey<FormState>();
  String? title, des, date, time, category;
  String? selectedItem = 'Urgent';

  // Variables for date and time
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // Method to pick a date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
      });
    }
  }

  // Method to pick a time
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        time = selectedTime!.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task Screen'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // To prevent overflow
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: key,
          child: Column(
            children: [
             const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Task Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Task Title';
                  }
                  return null;
                },
                onSaved: (value) {
                  title = value;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Task Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter short description of task';
                  }
                  return null;
                },
                onSaved: (value) {
                  des = value;
                },
              ),
             const  SizedBox(height: 10),

              // Date picker field
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: selectedDate == null
                      ? 'Select Date'
                      : 'Date: $date',
                  border: OutlineInputBorder(),
                ),
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (selectedDate == null) {
                    return 'Select a date for task execution';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // Time picker field
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: selectedTime == null
                      ? 'Select Time'
                      : 'Time: $time',
                  border: OutlineInputBorder(),
                ),
                onTap: () => _selectTime(context),
                validator: (value) {
                  if (selectedTime == null) {
                    return 'Select time for task execution';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              // DropdownButton for urgency levels
              DropdownButtonFormField<String>(
                value: selectedItem,
                decoration: const InputDecoration(
                  labelText:  'Task Urgency',
                  border:  OutlineInputBorder(),
                ),
                items: ['Urgent', 'Less Urgent', 'Least Urgent'].map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedItem = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Submission'),
                        content: const Text('Are you sure you want to submit the task?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Dismiss the dialog (Cancel action)
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // If validation is successful, save the form
                              if (key.currentState!.validate()) {
                                key.currentState!.save();

                                // Close the dialog
                                Navigator.of(context).pop();

                                // Show snackbar message after successful submission
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Task Added Successfully')),
                                );
                              }
                            },
                            child: Text('Save'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Save'),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
