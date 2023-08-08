import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Home/AppState.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;

  NoteCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Note: $title', // Add a label for accessibility
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0,
        child: ListTile(
          title: Text(title, style: TextStyle(fontSize: Provider.of<AppState>(context).fontSize),),
          subtitle: Text(content, style: TextStyle(fontSize: Provider.of<AppState>(context).fontSize),),
          onTap: () {
            // Handle tapping on the note card
          },
        ),
      ),
    );
  }
}
