import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onToggle;
  const TodoCard({super.key, required this.todo, this.onToggle});


@override
Widget build(BuildContext context) {
  return Card(
    color:Colors.orange,
    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 8,
    child: SizedBox(
      width: double.infinity,
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onToggle,
            icon: Icon(todo.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked, color: Colors.white)),
          const SizedBox(width: 8),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(todo.title, style: TextStyle(fontSize:24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                todo.detail,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              Text(DateFormat('yyyy年MM月dd日').format(todo.dueDate), style: TextStyle(fontSize: 12, color: Colors.black)),
            ],
          )),
        ]
      ),
    )
    );
  }
}
