import 'dart:convert'; // Todo ⇄ JSON（文字列）変換に使う
import 'package:shared_preferences/shared_preferences.dart'; // 端末に保存/読み込みするために使う
import '../models/todo.dart';

class TodoService {
  // 保存と読み込みで同じキーを使う（ここを変えたら両方揃えよう）
  static const String _storageKey = 'todos';
  final SharedPreferences _prefs;

  TodoService(this._prefs);

  // 端末に保存されているTodoリストを読み込む
  Future<List<Todo>> getTodos() async {
    // setStringで保存したJSON文字列を、同じキーで取り出そう
    final String? todosJson = _prefs.getString(_storageKey);

    // まだ何も保存されていないなら空リストでOK
    if (todosJson == null) return [];

    // JSON文字列 → List<dynamic> に戻す
    final List<dynamic> decoded = jsonDecode(todosJson);

    // decodedの各要素（Map）からTodoを復元してリストにしよう
    return decoded
        .map((json) => Todo(
              id: json['id'],
              title: json['title'],
              detail: json['detail'] ?? '',
              dueDate: DateTime.parse(json['dueDate'] ??
                  DateTime.now().toIso8601String()),
              isCompleted: json['isCompleted'],
            ))
        .toList();
  }

  // Todoリストを端末に保存する
  Future<void> saveTodos(List<Todo> todos) async {
    // Todo → Map の形にして、jsonEncodeできるようにしよう
    final List<Map<String, dynamic>> jsonData = todos
        .map((todo) => {
              'id': todo.id,
              'title': todo.title,
              'detail': todo.detail,
              'dueDate':
                  todo.dueDate.toIso8601String(), // DateTimeは文字列にして保存しよう
              'isCompleted': todo.isCompleted,
            })
        .toList();

    // Mapのリスト → JSON文字列に変換
    final String encoded = jsonEncode(jsonData);

    // JSON文字列を端末に保存しよう（読み込みはgetStringで同じキー）
    await _prefs.setString(_storageKey, encoded);
  }
}
