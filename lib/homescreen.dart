import 'package:alert_app/reminder.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'dbhelper.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  List<reminder> _reminders = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadreminders();
  }

  Future<void> _loadreminders() async {
    final reminders = await dbhelper().getreminders();
    setState(() {
      _reminders = reminders;
    });
  }

  Future<void> _deleteReminder(int? uid) async {
    await dbhelper().delete(uid);
    _loadreminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          automaticallyImplyLeading: false,
          title: const Text(
            'Reminders',
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
            )
        ),
        child: ListView.builder(
          itemCount: _reminders.length,
          itemBuilder: (context, index) {
            final reminder = _reminders[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(25),
                elevation: 10,
                child: ListTile(
                  title: Text(reminder.title),
                  subtitle: Text(reminder.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteReminder(reminder.uid);
                    },
                  ),
                ),
              ),
            );
          },
        ),

      ),
        bottomNavigationBar: buildBottomAppBar1(context)
    );
  }
}

