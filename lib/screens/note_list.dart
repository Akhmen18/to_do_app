import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:to_do_app/dbHelper.dart';
import 'package:to_do_app/note_app.dart';
import 'package:sqflite/sql.dart';
import 'package:to_do_app/screens/note_details.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DBHelper databaseHelper = DBHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('TO DO'),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          navigateToDetail(Note('', '', 2), 'Add Note');
        },
      ),
    );
  }

  void navigateToDetail(Note note, String title) async {
    bool res =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));

    if (res == true) {
      updateListView();
    }
  }

  ListView getNoteListView() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (context, position) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: Icon(Icons.perm_identity_rounded),
              title: Text(this.noteList[position].title),
              subtitle: Text(this.noteList[position].date),
              trailing: GestureDetector(
                child: Icon(Icons.open_in_new_outlined),
                onTap: () {
                  navigateToDetail(this.noteList[position], 'Edit');
                },
              ),
            ),
          );
        });
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
