import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/Services/ThemeService.dart';
import 'package:sign_in/Services/auth.dart';
import 'package:sign_in/screens/Home/AppState.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sign_in/screens/Home/AR.dart';
import 'package:sign_in/Models/Planets.dart';



// ignore: camel_case_types
class customDrawer extends StatefulWidget {
   final int selectedIndex;
   final Planet? selectedPlanet;

  const customDrawer(this.selectedIndex, {super.key, required this.selectedPlanet});



  @override
  State<customDrawer> createState() => _customDrawerState();

}

// ignore: camel_case_types
class _customDrawerState extends State<customDrawer> {
  final AuthService _auth= AuthService();
  final themeService _fontx = themeService();








  @override
  Widget build(BuildContext context) {

    User? user = FirebaseAuth.instance.currentUser;
    var appState = Provider.of<AppState>(context);


    return Drawer(



      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: null,
            accountEmail: Text(' ${user?.email ?? "N/A"}',  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: _fontx.getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
                fontSize: Provider.of<AppState>(context).fontSize ),),
            currentAccountPicture: Center(
              child: Image.asset(
                'assets/images/accessibility.png', // Replace with your image path
                width: 64.0, // Adjust the width as needed
                height: 64.0, // Adjust the height as needed
                alignment: Alignment.center,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.orange.shade700,
              gradient: const LinearGradient(
                colors: [Colors.orangeAccent, Colors.white54],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
         Expanded(
          child: ListView(
            children:   [
          Semantics(
            label:  AppLocalizations.of(context)!.home,
            child: ListTile(
              leading: const Icon(Icons.home),
            title: Text( AppLocalizations.of(context)!.home, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: _fontx.getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
                fontSize: Provider.of<AppState>(context).fontSize ),),
              onTap: () {
                var appState = Provider.of<AppState>(context, listen: false);
                appState.selectedIndex = 0;
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
              selected: appState.selectedIndex == 0,
              selectedTileColor: Colors.orange.shade100,
         ),
          ),
          Semantics(
            label:  AppLocalizations.of(context)!.arExperience,
            child: ListTile(
              leading: const Icon(Icons.camera),
              title: Text(AppLocalizations.of(context)!.arExperience,  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: _fontx.getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
                  fontSize: Provider.of<AppState>(context).fontSize ),),
              onTap: () {
                var appState = Provider.of<AppState>(context, listen: false);
                appState.selectedIndex = 1;
                Navigator.pop(context);
                Navigator.pushNamed(context, '/ar'); // Navigate to the AR screen
              },
              selected: appState.selectedIndex == 1,
              selectedTileColor: Colors.orange.shade100,
            ),
          ),
              Semantics(
                label:  AppLocalizations.of(context)!.notes,
                child: ListTile(
                  leading: const Icon(Icons.note_alt_sharp),
                  title: Text( AppLocalizations.of(context)!.notes, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: _fontx.getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
                      fontSize: Provider.of<AppState>(context).fontSize ),),
                  onTap: () {
                    var appState = Provider.of<AppState>(context, listen: false);
                    appState.selectedIndex = 2;
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/notes');
                  },
                  selected: appState.selectedIndex == 2,
                  selectedTileColor: Colors.orange.shade100,
                ),
              ),
          // Add more items as needed

              Semantics(
                label:  AppLocalizations.of(context)!.settings,
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(AppLocalizations.of(context)!.settings, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: _fontx.getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
                      fontSize: Provider.of<AppState>(context).fontSize )),
                  onTap: () {
                    var appState = Provider.of<AppState>(context, listen: false);
                    appState.selectedIndex = 3;
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/setting'); // Navigate to the AR screen
                  },
                  selected: appState.selectedIndex == 3,
                  selectedTileColor: Colors.orange.shade100,
                ),
              ),

              // Add more ListTile widgets as needed
              Semantics(
                label:  AppLocalizations.of(context)!.logout,
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(AppLocalizations.of(context)!.logout, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontFamily: _fontx.getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
                      fontSize: Provider.of<AppState>(context).fontSize )),
                  onTap: () async {
                    // Show a confirmation dialog
                    bool confirmLogout = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirm Logout'),
                        content: Text('Are you sure you want to log out?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false), // Cancel
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true), // Confirm
                            child: Text('Logout'),
                          ),
                        ],
                      ),
                    );

                    // If the user confirmed, log out
                    if (confirmLogout == true) {
                      await _auth.signOut(context);

                    }
                  },


                ),
              )



            ],
          ),
        ),
        ],
      ),

    );
  }
}
