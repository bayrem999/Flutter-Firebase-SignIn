import 'package:flutter/material.dart';
import 'package:sign_in/Services/ThemeService.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'AppState.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Models/Note.dart';
import '../../Services/auth.dart';
import '../../Services/noteS.dart';
import '../Notes/NoteCard.dart';
import 'package:sign_in/screens/Home/Settings.dart';
import 'package:sign_in/Theme/theme.dart';

import 'CustomDrawer.dart';

class notes extends StatefulWidget {
  const notes({super.key});

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  final AuthService _auth= AuthService();
  final NoteService _note = NoteService();
  final themeService _fontx = themeService();

  List<Note> notes = [];


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  late String _title;
  late String _content;
  final NoteService _noteS = NoteService();
  String? userId;


  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.orangeAccent,

        title: Text(

          AppLocalizations.of(context)!.notes, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: _fontx.getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
          fontSize: Provider.of<AppState>(context).fontSize,
        ),),
      ),
      drawer: customDrawer(appState.selectedIndex, selectedPlanet: null,),
      body: FutureBuilder<List<Note>>(
        future: _note.getNotesForCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching notes',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontFamily: _fontx.getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
              fontSize: Provider.of<AppState>(context).fontSize,)));
          } else if (snapshot.hasData) {
            List<Note> notes = snapshot.data!;

            return AnimatedList(
              key: _listKey,
              initialItemCount: notes.length,
              itemBuilder: (context, index, animation) {
                Note note = notes[index];
                return _buildAnimatedNoteItem(note, animation);
              },
            );
          } else {
            return Center(child: Text('No notes found',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontFamily: _fontx.getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
              fontSize: Provider.of<AppState>(context).fontSize )));
          }
        },
      ),
      floatingActionButton: Semantics(
        label: "Add note",
        child: FloatingActionButton(
          onPressed: () {
            _showAddNoteDialog();
          },
          child: Icon(Icons.add),
        ),
      ),


    );
  }

  Widget _buildAnimatedNoteItem(Note note, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: NoteCard(title: note.title, content: note.content, id: note.id,),
    );
  }



  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.addnote),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Semantics(
                  label:  AppLocalizations.of(context)!.titlebox,
                  child: TextFormField(
                    decoration: InputDecoration(labelText:  AppLocalizations.of(context)!.title),
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
                ),
                Semantics(
                  label: AppLocalizations.of(context)!.contentbox,
                  child: TextFormField(
                    decoration: InputDecoration(labelText: AppLocalizations.of(context)!.content),
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
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Semantics(
              label: AppLocalizations.of(context)!.cancelbutton,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.cancel,),
              ),
            ),
            Semantics(
              label: AppLocalizations.of(context)!.addbutton,
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _addNote(userId!);
                    Navigator.pop(context);


                  }
                },
                child: Text(AppLocalizations.of(context)!.add),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addNote(String userId) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Generate a unique ID for the note
      String noteId = const Uuid().v4();

      // Create a new Note object
      Note newNote = Note(
        id: noteId,
        title: _title,
        content: _content,
        timestamp: DateTime.now(),
      );

      // Save the note to Firebase using the NoteS class
      await _noteS.addNote(userId, newNote);

      List<Note> updatedNotes = await _note.getNotesForCurrentUser();

      setState(() {
        notes = updatedNotes;
      });
    }
  }
}
