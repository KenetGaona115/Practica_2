import 'package:hive/hive.dart';

part 'todo_remainder.g.dart';

@HiveType(typeId: 0, adapterName: "TodoReminderAdapter")
class TodoReminder {
  @HiveField(0)
  final String todoDescription;
  @HiveField(1)
  final String hour;

  TodoReminder({
    this.todoDescription,
    this.hour,
  });
}
// flutter packages pub run build_runner build
