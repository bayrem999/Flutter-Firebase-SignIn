import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'AppState.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sign_in/Models/Font.dart';



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
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontFamily: Provider.of<AppState>(context).selectedFont.filePath,
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
                  style: const TextStyle(color: Colors.orange),
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

                SettingsTile(
                  title: Text('Font'),
                  leading: Icon(Icons.font_download),
                  description: Text(appState.selectedFont.name),
                  onPressed: (context) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Select Font'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildFontOption(
                                'Calistoga',
                                'assets/fonts/Calistoga-Regular.ttf',
                                context,
                              ),
                              _buildFontOption(
                                'Times New Roman',
                                'assets/fonts/times_new_roman.ttf',
                                context,
                              ),
                              // Add more font options here
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),



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
            /*SettingsSection(
              title: Semantics(
                label:  AppLocalizations.of(context)!.language,
                child: const Text('Language', style: TextStyle(color: Colors.orange)),
              ),
              tiles: [
                SettingsTile(
                  title: const Text('Language'),
                  leading: const Icon(Icons.language),
                  description: Semantics(
                    label: _selectedLanguage,
                    child: Text(_selectedLanguage),
                  ),
                  onPressed: (context) {
                    _showLanguagePickerDialog();
                  },
                ),
              ],
            ),*/
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

  Widget _buildFontOption(String fontName, String fontPath, BuildContext context) {
    return ListTile(
      title: Text(fontName),
      onTap: () {
        var appState = Provider.of<AppState>(context, listen: false);
        appState.selectedFont = AppFont(name: fontName, filePath: fontPath);

        Navigator.pop(context); // Close the dialog after selection
      },
    );
  }




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
