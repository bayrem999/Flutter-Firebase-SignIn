import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sign_in/Models/User.dart';
import 'package:sign_in/Services/auth.dart';
import 'package:sign_in/l10n/l10n.dart';
import 'package:sign_in/screens/Home/AR.dart';
import 'package:sign_in/screens/Home/AppState.dart';
import 'package:sign_in/screens/Home/Settings.dart';
import 'package:sign_in/screens/Home/home_screen.dart';
import 'package:sign_in/screens/splach_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sign_in/Theme/theme.dart';
import 'package:sign_in/screens/Home/Settings.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // Initialization of Firebase app
  FlutterTts flutterTts = FlutterTts();

  runApp(



        ChangeNotifierProvider<AppState>(
          create: (context) => AppState(),
          child:  MyApp(),
        ),



  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final stt.SpeechToText _speech = stt.SpeechToText();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);


    return StreamProvider<Users?>.value(
      value: AuthService().user,
      initialData: null,
      child: Consumer<AppState>(
        builder: (context, appState, child) {
          // Access the AppState and get the isDarkModeEnabled property
          bool isDarkModeEnabled = appState.isDarkModeEnabled;

          return MaterialApp(



            debugShowCheckedModeBanner: false,
            supportedLocales: const [
              Locale('en', ''), // English, empty locale
              Locale('fr', ''), // French, empty locale
              // Add more supported locales as needed
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,

            ],

            title: 'My App',
              theme: getAppTheme(appState),

            routes: {
              '/home': (context) => const home(),
              '/ar': (context) =>  AR(),
              '/setting': (context) => const SettingsPage(),
            },
            home: const splach(),
          );
        },
      ),
    );
  }
}
