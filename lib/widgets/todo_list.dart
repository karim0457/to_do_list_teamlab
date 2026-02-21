import 'package:flutter/material.dart';

import '../models/todo.dart'; // 作成したTodoクラス
import '../services/todo_service.dart'; // データ保存サービス
import '../widgets/todo_card.dart'; // 作成したTodoCardウィジェット

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.todoService});

  final TodoService todoService; // getTodos/saveTodos を呼べるように受け取ろう

  @override
  State<TodoList> createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<Todo> _todos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTodos(); // 起動時に端末から読み込んで表示しよう
  }

  Future<void> loadTodos() async {
    // 端末保存から読み込んで、画面に反映しよう
    final todos = await widget.todoService.getTodos();
    setState(() {
      _todos = todos;
      _isLoading = false;
    });
  }

  // 追加画面から呼ばれる：リストに追加して保存まで行おう
  void addTodo(Todo newTodo) async {
    setState(() => _todos.add(newTodo));
    await widget.todoService.saveTodos(_todos);
  }
  Future<void> deleteTodo(Todo todo) async {
  // ① remove from list
  setState(() {
    _todos.removeWhere((t) => t.id == todo.id);
  });

  // ② save updated list to local storage
  await widget.todoService.saveTodos(_todos);
}

  // チェック（完了）ボタンから呼ばれる：削除して保存まで行おう
  Future<void> _toggleTodo(Todo todo) async {
  setState(() {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      final current = _todos[index];
      _todos[index] = current.copyWith(
        isCompleted: !current.isCompleted,
      );
    }
  });

  await widget.todoService.saveTodos(_todos);
}

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // 読み込み中はローディング表示にしよう
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (context, index) {
        final todo = _todos[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Dismissible(
  key: Key(todo.id),
  direction: DismissDirection.endToStart,
  onDismissed: (direction) {
    deleteTodo(todo);
  },
  background: Container(
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    color: Colors.red,
    child: const Icon(Icons.delete, color: Colors.white),
  ),
  child: TodoCard(
    todo: todo,
    onToggle: () => _toggleTodo(todo),
  ),
),
        );
      },
    );
  }
}
