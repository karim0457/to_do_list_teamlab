import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Todo App')),
        body: Center(
          child: SizedBox(
            height: 150,
            child: Card(
              child: Padding(
                padding:  const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.radio_button_unchecked),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:const[
                        Text('Sample Task'),
                        SizedBox(height: 4),
                        Text('sample description'),
                        SizedBox(height: 4),
                        Text('2024-06-30'),
                      ]
                      ),
                  ],
                ),
              ),
            )
          )
        ),
      ),
    );
  }
}
