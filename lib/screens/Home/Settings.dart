import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'AppState.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _currentFontSize = 16.0;
  bool _isDarkModeEnabled = false;
  String _selectedLanguage = 'English';


  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Appearance',style: TextStyle(color: Colors.orange)),
            tiles: [
             SettingsTile.switchTile(
               initialValue:  Provider.of<AppState>(context).isDarkModeEnabled,
                title: Text('Dark Mode'),
                leading: Icon(Icons.dark_mode),


                onToggle: (value) {
                  Provider.of<AppState>(context, listen: false).isDarkModeEnabled = value;
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('Language',style: TextStyle(color: Colors.orange)),
            tiles: [
              SettingsTile(
                title: Text('Language'),
                leading: Icon(Icons.language),
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

  List<Widget> _buildFontSizeTile() {
    return [ SettingsTile(
      title: Text('Text Size'),
      leading: Icon(Icons.text_fields),
      onPressed: (context) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Adjust Font Size'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Slider(
                    value: _currentFontSize,
                    min: 12.0,
                    max: 36.0,
                    divisions: 12,
                    label: _currentFontSize.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() {
                        _currentFontSize = value;
                        // Implement font size change logic here
                      });
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      trailing: Text(
        '${_currentFontSize.toStringAsFixed(1)}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),];
  }

  void _showLanguagePickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Language'),
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
