
import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String title;
  final String detail;
  final DateTime dueDate;
  final bool isCompleted;

  Todo({
    String? id,
    required this.title,
    required this.detail,
    required this.dueDate,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();


  Todo copyWith({
    String? title,
    String? detail,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return Todo(
      id: id,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
