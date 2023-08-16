import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'AppState.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sign_in/Models/Font.dart';
import 'package:sign_in/Theme/theme.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});



  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'English';
  bool _isHighContrastModeEnabled = false; // Set the initial value as needed




  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontFamily:
            _getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
            fontSize: Provider.of<AppState>(context).fontSize,
          ),
        ),


      ),
      body: Semantics(
        label:  AppLocalizations.of(context)!.settings,

        child: SettingsList(
          sections: [
            SettingsSection(
              title: Semantics(
                label:  AppLocalizations.of(context)!.appearance,
                child: Text(
                  AppLocalizations.of(context)!.appearance,
                  style: const TextStyle(color: Colors.orange, fontFamily: ''),
                ),
              ),
              tiles: [
                SettingsTile.switchTile(
                  initialValue: Provider.of<AppState>(context).isDarkModeEnabled,
                  title: Semantics(
                    label: AppLocalizations.of(context)!.darkMode,
                    child: Text(AppLocalizations.of(context)!.darkMode),
                  ),
                  leading: const Icon(Icons.dark_mode),
                  activeSwitchColor: Colors.orange,
                  onToggle: (value) {
                    Provider.of<AppState>(context, listen: false).isDarkModeEnabled = value;
                  },
                ),


               _buildFontSizeTile(context),
                _buildFontFamilyTile(context,appState),



                SettingsTile.switchTile(
                  initialValue: Provider.of<AppState>(context).isColorBlindModeEnabled,
                  title: Text('Color Blind Mode'),
                  leading: Icon(Icons.color_lens),
                  onToggle: (value) {
                    Provider.of<AppState>(context, listen: false).isColorBlindModeEnabled = value;
                  },
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }
  SettingsTile _buildFontSizeTile(BuildContext context) {
    return SettingsTile(
      title:  Text(AppLocalizations.of(context)!.fontSize),
      leading: const Icon(Icons.text_fields),
      onPressed: _showFontSizeDialog,
    );
  }

  // change font




  String _getFontFamilyFromAppFont(AppFont appFont) {
    switch (appFont) {
      case AppFont.roboto:
        return 'Roboto';
      case AppFont.openDyslexic:
        return 'OpenDyslexic'; // Replace with actual font family name
      case AppFont.dinAlternate:
        return 'DINAlternate'; // Replace with actual font family name
    }
  }

  String _getFontName(AppFont font) {
    switch (font) {
      case AppFont.roboto:
        return 'Roboto';
      case AppFont.openDyslexic:
        return 'OpenDyslexic'; // Replace with actual font name
      case AppFont.dinAlternate:
        return 'DIN Alternate'; // Replace with actual font name
    }
  }

  SettingsTile _buildFontFamilyTile(BuildContext context, AppState appState) {
    return SettingsTile(
      title: Semantics(
        label: 'Font Family', // You can localize this label if needed
        child: Text('Font Family'),
      ),
      description: Text(
        _getFontName(appState.selectedFont),
        style: TextStyle(fontFamily: _getFontFamilyFromAppFont(appState.selectedFont)),
      ),
      leading: Icon(Icons.font_download),
      onPressed: (_) {
        print('Current Font: ${appState.selectedFont}'); // Debug print
        _showFontDialog(appState,context);
        setState(() {
          // Trigger a rebuild to apply font changes
        });
      },
    );
  }



  void _showFontDialog(AppState appState, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Font Family'),
        content: DropdownButton<AppFont>(
          value: appState.selectedFont,
          onChanged: (newFont) {
            setState(() {
              appState.changeFont(newFont!);
            });
            Navigator.pop(context);
          },
          items: AppFont.values.map((font) {
            return DropdownMenuItem<AppFont>(
              value: font,
              child: Text(_getFontName(font)),
            );
          }).toList(),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              print('Current Font: ${appState.selectedFont}'); // Debug print

            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }



// end change font

  void _showFontSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        double newFontSize = Provider.of<AppState>(context, listen: false).fontSize;

        return Semantics(
          label: 'Choose Font Size Dialog',
          child: AlertDialog(
            title: const Text('Choose Font Size'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            content: SingleChildScrollView(
              physics: const ClampingScrollPhysics(), // Add this line to make the content scrollable
              child: ListBody(
                children: [
                  Semantics(
                    label: 'Font Size Slider , slide to change size',
                    child: Slider(
                      value: newFontSize,
                      min: 10.0,
                      max: 30.0,
                      onChanged: (value) {
                        Provider.of<AppState>(context, listen: false).fontSize = value;
                        newFontSize = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Semantics(
                label : 'Cancel button',
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              Semantics(
                label : 'Save button',
                child: TextButton(
                  onPressed: () {
                    // Save the new font size in preferences or wherever you want to persist it.
                    // Then close the dialog.
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  /*void _showLanguagePickerDialog() {
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
  }*/

  /*Widget _buildLanguageOption(String language) {
    bool isSelected = _selectedLanguage == language;
    return RadioListTile(
      value: language,
      groupValue: _selectedLanguage,
      title: Text(language),
      onChanged: (value) {
        setState(() {
          _selectedLanguage = value as String;
          // Implement language change logic here
          final appState = Provider.of<AppState>(context, listen: false);

          // Update the app's locale
          appState.(Locale(_selectedLanguage));

          // Close the dialog after selection
          Navigator.pop(context);
        });
      },
      selected: isSelected,
    );
  }*/

  void toggleHighContrastMode() {
    setState(() {
      _isHighContrastModeEnabled = !_isHighContrastModeEnabled;
    });
  }
}
