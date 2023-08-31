import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'AppState.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sign_in/Models/Font.dart';
import 'package:sign_in/Theme/theme.dart';

import 'CustomDrawer.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});



  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'French';

  bool _isHighContrastModeEnabled = false; // Set the initial value as needed


  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context, listen: false);
    var selectedLocale = Localizations.localeOf(context).toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: Theme
              .of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(
            fontFamily:
            _getFontFamilyFromAppFont(Provider
                .of<AppState>(context)
                .selectedFont),
            fontSize: Provider
                .of<AppState>(context)
                .fontSize,
          ),
        ),


      ),
      drawer: customDrawer(appState.selectedIndex, selectedPlanet: null,),
      body: Semantics(
        label: AppLocalizations.of(context)!.settings,


        child: SettingsList(
          sections: [
            SettingsSection(
              title: Semantics(
                label: AppLocalizations.of(context)!.appearance,
                child: Text(
                  AppLocalizations.of(context)!.appearance,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                    fontFamily:
                    _getFontFamilyFromAppFont(Provider
                        .of<AppState>(context)
                        .selectedFont),
                    fontSize: Provider
                        .of<AppState>(context)
                        .fontSize,
                  ),
                ),
              ),
              tiles: [

                SettingsTile.switchTile(
                  initialValue: Provider
                      .of<AppState>(context)
                      .isDarkModeEnabled,
                  title: Semantics(
                    label: AppLocalizations.of(context)!.darkMode,
                    child: Text(AppLocalizations.of(context)!.darkMode,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        fontFamily:
                        _getFontFamilyFromAppFont(Provider
                            .of<AppState>(context)
                            .selectedFont),
                        fontSize: Provider
                            .of<AppState>(context)
                            .fontSize,
                      ),
                    ),
                  ),
                  leading: const Icon(Icons.dark_mode),
                  activeSwitchColor: Colors.orange,
                  onToggle: (value) {
                    Provider
                        .of<AppState>(context, listen: false)
                        .isDarkModeEnabled = value;
                  },
                ),


                _buildFontSizeTile(context),
                _buildFontFamilyTile(context, appState),


                SettingsTile.switchTile(
                  initialValue: Provider
                      .of<AppState>(context)
                      .isColorBlindModeEnabled,
                  title: Text('Color Blind Mode',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                      fontFamily:
                      _getFontFamilyFromAppFont(Provider
                          .of<AppState>(context)
                          .selectedFont),
                      fontSize: Provider
                          .of<AppState>(context)
                          .fontSize,
                    ),),
                  leading: Icon(Icons.color_lens),
                  onToggle: (value) {
                    Provider
                        .of<AppState>(context, listen: false)
                        .isColorBlindModeEnabled = value;
                  },
                ),
                SettingsTile(
                  leading: Icon(Icons.language),
                  title: Text(AppLocalizations.of(context)!.changelanguage,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                      fontFamily:
                      _getFontFamilyFromAppFont(Provider
                          .of<AppState>(context)
                          .selectedFont),
                      fontSize: Provider
                          .of<AppState>(context)
                          .fontSize,
                    ),),
                  onPressed: (_) {
                    showDialog(
                      context: context,
                      builder: (context) => _buildLanguageDialog(context),
                    );
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
      title: Text(AppLocalizations.of(context)!.fontSize),
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
        child: Text('Font Family', style: Theme
            .of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(
          fontFamily:
          _getFontFamilyFromAppFont(Provider
              .of<AppState>(context)
              .selectedFont),
          fontSize: Provider
              .of<AppState>(context)
              .fontSize,
        ),),
      ),
      description: Text(
        _getFontName(appState.selectedFont),
        style: TextStyle(
            fontFamily: _getFontFamilyFromAppFont(appState.selectedFont)),
      ),
      leading: Icon(Icons.font_download),
      onPressed: (_) {
        print('Current Font: ${appState.selectedFont}'); // Debug print
        _showFontDialog(appState, context);
        setState(() {
          // Trigger a rebuild to apply font changes
        });
      },
    );
  }


  void _showFontDialog(AppState appState, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Select Font Family', style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
              fontFamily:
              _getFontFamilyFromAppFont(Provider
                  .of<AppState>(context)
                  .selectedFont),
              fontSize: Provider
                  .of<AppState>(context)
                  .fontSize,
            ),),
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
                  print(
                      'Current Font: ${appState.selectedFont}'); // Debug print

                },
                child: Text('Cancel', style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                  fontFamily:
                  _getFontFamilyFromAppFont(Provider
                      .of<AppState>(context)
                      .selectedFont),
                  fontSize: Provider
                      .of<AppState>(context)
                      .fontSize,
                ),),
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
        double newFontSize = Provider
            .of<AppState>(context, listen: false)
            .fontSize;

        return Semantics(
          label: 'Choose Font Size Dialog',
          child: AlertDialog(
            title: Text('Choose Font Size', style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
              fontFamily:
              _getFontFamilyFromAppFont(Provider
                  .of<AppState>(context)
                  .selectedFont),
              fontSize: Provider
                  .of<AppState>(context)
                  .fontSize,
            ),),
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              // Add this line to make the content scrollable
              child: ListBody(
                children: [
                  Semantics(
                    label: 'Font Size Slider , slide to change size',
                    child: Slider(
                      value: newFontSize,
                      min: 10.0,
                      max: 30.0,
                      onChanged: (value) {
                        Provider
                            .of<AppState>(context, listen: false)
                            .fontSize = value;
                        newFontSize = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Semantics(
                label: 'Cancel button',
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel', style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                    fontFamily:
                    _getFontFamilyFromAppFont(Provider
                        .of<AppState>(context)
                        .selectedFont),
                    fontSize: Provider
                        .of<AppState>(context)
                        .fontSize,
                  ),),
                ),
              ),
              Semantics(
                label: 'Save button',
                child: TextButton(
                  onPressed: () {
                    // Save the new font size in preferences or wherever you want to persist it.
                    // Then close the dialog.
                    Navigator.pop(context);
                  },
                  child: Text('Save', style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                    fontFamily:
                    _getFontFamilyFromAppFont(Provider
                        .of<AppState>(context)
                        .selectedFont),
                    fontSize: Provider
                        .of<AppState>(context)
                        .fontSize,
                  ),),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  void toggleHighContrastMode() {
    setState(() {
      _isHighContrastModeEnabled = !_isHighContrastModeEnabled;
    });
  }

  Widget _buildLanguageDialog(BuildContext context) {
    final languageProvider = Provider.of<AppState>(context, listen: false);

    return AlertDialog(
      title: Text('Select Language'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLanguageOption(context, 'English', Locale('en')),
          _buildLanguageOption(context, 'French', Locale('fr')),
        ],
      ),
    );
  }

  ListTile _buildLanguageOption(BuildContext context, String label, Locale locale) {
    final languageProvider = Provider.of<AppState>(context, listen: false);
    return ListTile(
      title: Text(label),
      onTap: () {
        // Change the language
        languageProvider.changeLanguage(locale);

        // Show confirmation dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Language Changed'),
            content: Text('Language changed to $label. Do you want to save this choice?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Save the language choice
                  // You can save it using shared preferences or any other method
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

}
