import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/screens/Home/AR.dart';
import 'package:sign_in/Services/auth.dart';
import 'package:sign_in/screens/Authentification/ForgotPass.dart';
import 'package:sign_in/screens/Home/AppState.dart';
import 'package:sign_in/screens/Home/home_screen.dart';


class customDrawer extends StatefulWidget {
  late final int selectedIndex;

  customDrawer(this.selectedIndex);



  @override
  State<customDrawer> createState() => _customDrawerState();

}

class _customDrawerState extends State<customDrawer> {
  final AuthService _auth= AuthService();




  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var appState = Provider.of<AppState>(context);


    return Drawer(



      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("_auth.user."),
            accountEmail: Text('Email: ${user?.email ?? "N/A"}', style: TextStyle(fontSize: Provider.of<AppState>(context).fontSize),),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
            decoration: BoxDecoration(
              color: Colors.orange.shade700,
              gradient: LinearGradient(
                colors: [Colors.black, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
         Expanded(
          child: ListView(
            children:   [
          ListTile(
            leading: Icon(Icons.home),
          title: Text('Home', style: TextStyle(fontSize: Provider.of<AppState>(context).fontSize),),
            onTap: () {
              var appState = Provider.of<AppState>(context, listen: false);
              appState.selectedIndex = 0;
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
            selected: appState.selectedIndex == 0,
            selectedTileColor: Colors.orange.shade100,
         ),
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('AR experience', style: TextStyle(fontSize: Provider.of<AppState>(context).fontSize),),
            onTap: () {
              var appState = Provider.of<AppState>(context, listen: false);
              appState.selectedIndex = 1;
              Navigator.pop(context);
              Navigator.pushNamed(context, '/ar'); // Navigate to the AR screen
            },
            selected: appState.selectedIndex == 1,
            selectedTileColor: Colors.orange.shade100,
          ),
          // Add more items as needed

              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings', style: TextStyle(fontSize: Provider.of<AppState>(context).fontSize),),
                onTap: () {
                  var appState = Provider.of<AppState>(context, listen: false);
                  appState.selectedIndex = 2;
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/setting'); // Navigate to the AR screen
                },
                selected: appState.selectedIndex == 2,
                selectedTileColor: Colors.orange.shade100,
              ),

              // Add more ListTile widgets as needed
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout', style: TextStyle(fontSize: Provider.of<AppState>(context).fontSize),),
                onTap: () async {
                  await _auth.signOut();

                },

              )



            ],
          ),
        ),
        ],
      ),

    );
  }
}
