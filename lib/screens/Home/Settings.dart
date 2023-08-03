import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'AppState.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});



  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'English';


  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(

          AppLocalizations.of(context)!.settings, style: TextStyle(fontSize: Provider.of<AppState>(context).fontSize),),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Appearance',style: TextStyle(color: Colors.orange)),
            tiles: [
             SettingsTile.switchTile(
               initialValue:  Provider.of<AppState>(context).isDarkModeEnabled,
                title: const Text('Dark Mode'),
                leading: const Icon(Icons.dark_mode),
               activeSwitchColor:  Colors.orange, // Customize the active color for dark mode
               //switchActiveTrackColor: Colors.orange.shade200, // Customize the track color for dark mode

                onToggle: (value) {
                  Provider.of<AppState>(context, listen: false).isDarkModeEnabled = value;
                },
              ),
              _buildFontSizeTile(context),
            ],


          ),

          SettingsSection(
            title: const Text('Language',style: TextStyle(color: Colors.orange)),
            tiles: [
              SettingsTile(
                title: const Text('Language'),
                leading: const Icon(Icons.language),
                description: Text(_selectedLanguage),
                onPressed: (context) {
                  _showLanguagePickerDialog();
                },
              ),
            ],
          ),

        ],
      ),
    );
  }
  SettingsTile _buildFontSizeTile(BuildContext context) {
    return SettingsTile(
      title: const Text('Font Size'),
      leading: const Icon(Icons.text_fields),
      onPressed: _showFontSizeDialog,
    );
  }

  void _showFontSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        double newFontSize = Provider.of<AppState>(context, listen: false).fontSize;

        return AlertDialog(
          title: const Text('Choose Font Size'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: SingleChildScrollView(
            physics: const ClampingScrollPhysics(), // Add this line to make the content scrollable
            child: ListBody(
              children: [
                Slider(
                  value: newFontSize,
                  min: 10.0,
                  max: 30.0,
                  onChanged: (value) {
                    Provider.of<AppState>(context, listen: false).fontSize = value;
                    newFontSize = value;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Save the new font size in preferences or wherever you want to persist it.
                // Then close the dialog.
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
  void _showLanguagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('English'),
              _buildLanguageOption('French'),
              // Add more language options here
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language) {
    bool isSelected = _selectedLanguage == language;
    return RadioListTile(
      value: language,
      groupValue: _selectedLanguage,
      title: Text(language),
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value as String;
          // Implement language change logic here
        });
        Navigator.pop(context); // Close the dialog after selection
      },
      selected: isSelected,
    );
  }
}
