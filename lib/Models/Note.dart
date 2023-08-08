
import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String id;
  String title;
  String content;
  DateTime timestamp;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
  });
}