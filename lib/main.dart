import 'package:flutter/material.dart';
import 'package:to_do_app/screens/note_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDoApp',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: NoteList(),
    );
  }
}
