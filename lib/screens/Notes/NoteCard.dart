import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/Services/ThemeService.dart';

import '../../Services/noteS.dart';
import '../Home/AppState.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String content;
  final String id;
  final NoteService _noteS = NoteService();

  NoteCard({required this.title, required this.content, required this.id});

  @override
  Widget build(BuildContext context) {
    final themeService _fontx = themeService();
    return Semantics(
      label: 'Note: $title', // Add a label for accessibility
      child: Dismissible(
        key: Key(id),
        onDismissed: (direction) {
          // Call the delete function from NoteService here

        },

        child: Card(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4.0,
          child: ListTile(
            title: Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: _fontx.getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
                fontSize: Provider.of<AppState>(context).fontSize ),),
            subtitle: Text(content, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: _fontx.getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
                fontSize: Provider.of<AppState>(context).fontSize ),),
            onTap: () {
              // Handle tapping on the note card
            },
          ),
        ),
      ),
    );
  }
}
