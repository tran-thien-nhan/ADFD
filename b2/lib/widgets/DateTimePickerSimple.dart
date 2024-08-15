import 'package:flutter/material.dart';

class Datetimepickersimple extends StatefulWidget {
  const Datetimepickersimple({super.key});

  @override
  State<Datetimepickersimple> createState() => _DatetimepickersimpleState();
}

class _DatetimepickersimpleState extends State<Datetimepickersimple> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _chooseDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _chooseTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DateTime Picker Simple'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Selected Date: ${_selectedDate.toLocal()}".split(' ').first,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
            const SizedBox(height: 10),
            Text("Selected Time: ${_selectedTime.format(context)}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _chooseDate(context),
              child: const Text('Choose Date'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _chooseTime(context),
              child: const Text('Choose Time'),
            ),
          ],
        ),
      ),
    );
  }
}
