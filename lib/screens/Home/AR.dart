import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/screens/Home/AppState.dart';
import 'package:sign_in/screens/Home/CustomDrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:object_3d/object_3d.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math.dart' show Vector3;

class AR extends StatefulWidget {
  AR({super.key});



  @override
  State<AR> createState() => _ARState();

}

class _ARState extends State<AR> {
  ArCoreController? arCoreController;
  String selectedPlanet = 'earth'; // Default planet
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return  Scaffold(

      appBar: AppBar(),

      body: Column(
        children: [
          Expanded(
            child: ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
            )
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPlanetButton('earth'),
                _buildPlanetButton('mars'),
                _buildPlanetButton('venus'),
              ],
            ),
          ),
        ],
      ),

      drawer: customDrawer(appState.selectedIndex),
    );
  }
void _onArCoreViewCreated(ArCoreController controller){
arCoreController = controller;/*
arCoreController?.addArCoreNode(
  ArCoreNode(
    shape: ArCoreCube(
      materials: [ArCoreMaterial(color: Colors.blue)], size: null,
    ),
    position: Vector3(0, 0, -1),
  ),
);*/
}

  Widget _buildPlanetButton(String planet) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedPlanet = planet;
        });
      },
      child: Text(planet),
    );
  }
}


