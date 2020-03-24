part of 'reminder_bloc.dart';

abstract class ReminderEvent extends Equatable {
  const ReminderEvent();
}

class OnAddElementEvent extends ReminderEvent {
  final TodoReminder todoReminder;

  OnAddElementEvent({@required this.todoReminder});
  @override
  List<Object> get props => [todoReminder];
}

class OnRemoveElementEvent extends ReminderEvent {
  final int removedAtIndex;

  OnRemoveElementEvent({@required this.removedAtIndex});
  @override
  List<Object> get props => [removedAtIndex];
}

class OnReminderAddedEvent extends ReminderEvent {
  @override
  List<Object> get props => [];
}

class OnLoadRemindersEvent extends ReminderEvent {
  @override
  List<Object> get props => [];
}
