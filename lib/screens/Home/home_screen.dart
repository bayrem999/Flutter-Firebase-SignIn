// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/Services/auth.dart';
import 'package:sign_in/screens/Home/AppState.dart';
import 'package:sign_in/screens/Home/CustomDrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sign_in/Models/Note.dart';
import 'package:sign_in/Services/noteS.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';


import '../Notes/NoteCard.dart';


class home extends StatefulWidget {
  const home({super.key});



  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final AuthService _auth= AuthService();
  final NoteService _note = NoteService();



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;
  final NoteService _noteS = NoteService();
  String? userId;

  @override
  Widget build(BuildContext context) {

    User? user = FirebaseAuth.instance.currentUser;
     userId = user?.uid;
    var appState = Provider.of<AppState>(context);

    return Scaffold(

      backgroundColor: Colors.blueAccent[50],
      appBar: AppBar(

        title: Text(AppLocalizations.of(context)!.homePage, style: TextStyle(fontSize: Provider.of<AppState>(context).fontSize),),
        backgroundColor: Colors.black,
        elevation: 0.0,

      ),
      drawer: customDrawer(appState.selectedIndex),

      body: FutureBuilder<List<Note>>(
        future: _note.getNotesForCurrentUser( userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching notes'));
          } else if (snapshot.hasData) {
            List<Note> notes = snapshot.data!;

            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                Note note = notes[index];
                return NoteCard(title: note.title, content: note.content);
              },
            );
          } else {
            return Center(child: Text('No notes found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddNoteDialog();
        },
        child: Icon(Icons.add),
      ),


    );
  }

  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Content'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter content';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _content = value!;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addNote(userId!);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addNote(String userId) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Generate a unique ID for the note
      String noteId = Uuid().v4();

      // Create a new Note object
      Note newNote = Note(
        id: noteId,
        title: _title,
        content: _content,
        timestamp: DateTime.now(),
      );

      // Save the note to Firebase using the NoteS class
      _noteS.addNote(userId, newNote);
    }
  }


  }

