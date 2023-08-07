import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in/Models/Note.dart';
import 'package:sign_in/Services/auth.dart';

class NoteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'notes'; // Replace with your collection path
  User? user = FirebaseAuth.instance.currentUser;
  final AuthService _auth= AuthService();



  Future<void> addNote(String userId, Note note) async {
    await _firestore
        .collection(_collectionPath)
        .doc(userId)
        .collection('user_notes')
        .doc(note.id)
        .set({
      'title': note.title,
      'content': note.content,
      'timestamp': note.timestamp,
    });
  }

  String getCurrentUserId() {

    if (user != null) {
      return user.uid;
    }
    return null;
  }

  // Get all notes for a specific user
  Future<List<Note>> getNotesForCurrentUser() async {

    if (userId == null) {
      return []; // Return an empty list if the user is not logged in
    }

    try {
      final snapshot = await _firestore
          .collection(_collectionPath)
          .doc(userId)
          .collection('user_notes')
          .get();

      List<Note> notes = [];
      snapshot.docs.forEach((doc) {
        // Create Note objects from the snapshot data
        notes.add(Note(
          id: doc.id,
          title: doc.data()['title'],
          content: doc.data()['content'],
          timestamp: doc.data()['timestamp'],
        ));
      });

      return notes;
    } catch (e) {
      print('Error fetching notes: $e');
      return []; // Return an empty list in case of any error
    }
  }
}



  // Update note for a specific user


  // Delete note for a specific user


