import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/screens/Home/AppState.dart';
import 'package:sign_in/screens/Home/CustomDrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AR extends StatelessWidget {
  const AR({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return  Scaffold(

      appBar: AppBar(),
      body:  Center(child: Text(AppLocalizations.of(context)!.greeting)),
      drawer: customDrawer(appState.selectedIndex),
    );
  }
}
