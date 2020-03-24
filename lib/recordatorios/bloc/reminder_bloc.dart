import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:practica_dos/models/todo_remainder.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  Box _hiveRemindersBox;
  ReminderBloc() {
    // abrir la box
    _hiveRemindersBox = Hive.box("reminders");
  }

  @override
  ReminderState get initialState => HomeInitialState();

  @override
  Stream<ReminderState> mapEventToState(
    ReminderEvent event,
  ) async* {
    if (event is OnLoadRemindersEvent) {
      try {
        List<TodoReminder> _existingReminders = _loadReminders();
        yield LoadedRemindersState(todosList: _existingReminders);
      } on DatabaseDoesNotExist catch (_) {
        yield NoRemindersState();
      } on EmptyDatabase catch (_) {
        yield NoRemindersState();
      }
    }
    if (event is OnAddElementEvent) {
      _saveTodoReminder(event.todoReminder);
      yield NewReminderState(todo: event.todoReminder);
    }
    if (event is OnReminderAddedEvent) {
      yield AwaitingEventsState();
    }
    if (event is OnRemoveElementEvent) {
      _removeTodoReminder(event.removedAtIndex);
    }
  }

  List<TodoReminder> _loadReminders() {
    // ver si existen datos TodoReminder en la box y sacarlos como Lista
    try {
      if (_hiveRemindersBox.values.first == null) throw EmptyDatabase();
      return _hiveRemindersBox.values
          .map((savedItem) => savedItem as TodoReminder)
          .toList();
    } catch (e) {
      throw EmptyDatabase();
    }
  }

  void _saveTodoReminder(TodoReminder todoReminder) {
    _hiveRemindersBox.add(todoReminder);
  }

  void _removeTodoReminder(int removedAtIndex) {
    _hiveRemindersBox.deleteAt(removedAtIndex);
  }
}

class DatabaseDoesNotExist implements Exception {}

class EmptyDatabase implements Exception {}
