import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:to_do_list_teamlab/main.dart';
import 'package:to_do_list_teamlab/services/todo_service.dart';

void main() {
  testWidgets('Todo app loads and shows add button', (WidgetTester tester) async {
    // ✅ Mock local storage
    SharedPreferences.setMockInitialValues({});

    // ✅ Create SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    // ✅ Create your TodoService
    final todoService = TodoService(prefs);

    // ✅ Build the app
    await tester.pumpWidget(MyApp(todoService: todoService));

    // wait for first frame
    await tester.pumpAndSettle();

    // ✅ Check main screen loaded
    expect(find.byType(Scaffold), findsOneWidget);

    // ✅ Check that add button exists
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
