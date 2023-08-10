import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/screens/Home/AppState.dart';
import 'package:sign_in/screens/Home/CustomDrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:object_3d/object_3d.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

import 'package:vector_math/vector_math_64.dart';
import '../../Models/Planets.dart';

class AR extends StatefulWidget {
  AR( {super.key, required this.planet});
  final Planet planet;




  @override
  State<AR> createState() => _ARState();

}

class _ARState extends State<AR> {
  ArCoreController? arCoreController;
  String selectedPlanet = 'earth'; // Default planet

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    final planet = ModalRoute.of(context)?.settings.arguments as Planet?;
    return  Scaffold(

      appBar: AppBar(title: Text(widget.planet.name),
        /*leading: BackButton(
        color: Colors.white,
      ),
      backgroundColor: Colors.black,*/
      ),

      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
      ),


    );
  }
void _onArCoreViewCreated(ArCoreController controller){
arCoreController = controller;
_loadPlanetModel();


}

  void _loadPlanetModel() async {
    final planetNode = ArCoreReferenceNode(
      objectUrl: widget.planet.modelPath,
      scale: widget.planet.scale != null ? Vector3(1, 1, 1) : null,
      position: widget.planet.scale != null ? Vector3(0, 0, -1.5) : null,
      rotation: widget.planet.scale != null ? Vector4(0, 1, 0, 0) : null,
    );

    arCoreController?.addArCoreNode(planetNode);
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


