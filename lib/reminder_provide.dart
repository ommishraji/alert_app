import 'package:alert_app/dbhelper.dart';
import 'package:alert_app/reminder.dart';
import 'package:flutter/foundation.dart';

class reminder_provider with ChangeNotifier{
  List<reminder> _reminders = [];
  List<reminder> get reminders => _reminders;

  Future<void> loadreminders() async {
    _reminders = await dbhelper().getreminders();
    notifyListeners();
  }

  Future<void> addreminder(reminder Rreminder) async {
    await dbhelper().insert(Rreminder);
    await loadreminders();
  }

  Future<void> updatereminder(reminder Rreminder) async {
    await dbhelper().update(Rreminder);
    await loadreminders();
  }

  Future<void> deletereminder(int id) async {
    await dbhelper().delete(id);
    await loadreminders();
  }
}