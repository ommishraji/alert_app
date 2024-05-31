import 'dart:math';

import 'package:alert_app/notification.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'reminder.dart';
import 'dbhelper.dart';

class addreminder extends StatefulWidget {
  const addreminder({super.key});

  @override
  State<addreminder> createState() => _addreminderState();
}

class _addreminderState extends State<addreminder> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _dateTime = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _dateTime.hour,
          _dateTime.minute,
        );
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dateTime),
    );
    if (picked != null) {
      setState(() {
        _dateTime = DateTime(
          _dateTime.year,
          _dateTime.month,
          _dateTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }
  int _generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch + Random().nextInt(1000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
        title: const Text(
          'Add Reminder',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.pink,
                  Colors.purple
                ]
            ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.purple.shade50,
                    child: TextFormField(
                      decoration: boxkadecoration1.copyWith(hintText: 'Alert Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _title = value!;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.purple.shade50,
                    child: TextFormField(
                      decoration: boxkadecoration1.copyWith(hintText: 'Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _description = value!;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: Text('Select date',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _selectTime(context),
                          child: Text('Select time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                          ),),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Selected date time is: ${_dateTime.hour}:${_dateTime.minute} on ${_dateTime.day}-${_dateTime.month}:${_dateTime.year}',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final Rreminder = reminder(
                        uid: _generateUniqueId()%200,
                        title: _title,
                        description: _description,
                        dateTime: _dateTime,
                      );
                      await dbhelper().insert(Rreminder);
                      await notification().scheduleNotification(
                        Rreminder.uid ?? 0,
                        Rreminder.title,
                        Rreminder.description,
                        Rreminder.dateTime as DateTime,
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Save',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: bottombar2(context),

    );
  }
}
