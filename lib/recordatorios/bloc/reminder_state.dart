part of 'reminder_bloc.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();
}

class HomeInitialState extends ReminderState {
  @override
  List<Object> get props => [];
}

class LoadedRemindersState extends ReminderState {
  final List<TodoReminder> todosList;

  LoadedRemindersState({@required this.todosList});
  @override
  List<Object> get props => [todosList];
}

class NewReminderState extends ReminderState {
  final TodoReminder todo;

  NewReminderState({@required this.todo});
  @override
  List<Object> get props => [todo];
}

class AwaitingEventsState extends ReminderState {
  @override
  List<Object> get props => [];
}

class NoRemindersState extends ReminderState {
  @override
  List<Object> get props => [];
}
