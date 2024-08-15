import 'package:flutter/material.dart';
import 'package:test/DatabaseHelper.dart';
import 'employee.dart';

class CreateEmployee extends StatefulWidget {
  @override
  _CreateEmployeeState createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _gender;
  String? _skills;

  DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  } else if (value.length < 5 || value.length > 30) {
                    return 'Name must be between 5 and 30 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select gender'),
                value: _gender,
                onChanged: (String? newValue) {
                  setState(() {
                    _gender = newValue;
                  });
                },
                items: <String>['Male', 'Female', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a gender';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter skills'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter skills';
                  }
                  return null;
                },
                onSaved: (value) {
                  _skills = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Employee newEmployee = Employee(
                        name: _name!,
                        gender: _gender!,
                        skills: _skills!,
                      );
                      dbHelper.insertEmployee(newEmployee).then((value) {
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
