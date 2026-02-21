import 'package:flutter/material.dart';

import '../services/todo_service.dart';
import '../widgets/todo_list.dart';
import 'add_todo_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key, required this.todoService});

  final TodoService todoService;

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  // Todo追加後に TodoList を作り直すためのキー（再読み込みのトリガー）
  final GlobalKey<TodoListState> _todoListKey = GlobalKey<TodoListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TODOリスト')),
      body: TodoList(
        key: _todoListKey,
        todoService: widget.todoService,
      ), // TodoList ウィジェットを配置
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // 追加画面へ行き、戻ってきたときに「更新があったか」を受け取ろう（true/false）
          final updated = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoScreen(
                todoService: widget.todoService, // 追加画面でも保存できるように渡そう
              ),
            ),
          );

          // 追加があったら再描画（TodoList を再取得）
          if (updated == true) {
            _todoListKey.currentState?.loadTodos();
          }
        },
        backgroundColor: const Color.fromARGB(255, 39, 0, 168), // ボタンの背景色
        foregroundColor: Colors.white, // ボタン内のアイコン色
        child: const Icon(Icons.add), // Flutter標準の「＋」アイコン
      ),
    );
  }
}
