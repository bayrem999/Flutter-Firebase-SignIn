import 'dart:typed_data';

import 'package:flutter/material.dart' hide Colors ;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/screens/Home/AppState.dart';
import 'package:sign_in/screens/Home/CustomDrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:object_3d/object_3d.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/src/material/colors.dart ';
import 'package:vector_math/vector_math_64.dart' as vector64 ;
import '../../Models/Planets.dart';

class AR extends StatefulWidget {




  @override
  _ARState createState() => _ARState();
}

class _ARState extends State<AR> {
  late ArCoreController arCoreController;
  late  Planet defaultPlanet = Planet(name: 'Earth', modelPath: 'assets/3d_objects/earth.glb');


  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();

  }

  void _onArViewCreated(ArCoreController controller) {
    arCoreController = controller;

    displayearthmap(arCoreController);

  }

  displayearthmap (ArCoreController controller ) async {

    final ByteData  earthtexturebytes = await rootBundle.load("assets/3d_objects/earth_map.jpg");
    final materials = ArCoreMaterial(
      color: Colors.blue ,
      textureBytes: earthtexturebytes.buffer.asUint8List() ,

    );
    final sphere = ArCoreSphere(materials: [materials],

    );

    final node = ArCoreNode(

      shape:sphere,
      position: vector64.Vector3(1,0, -1.5),
    );
    arCoreController.addArCoreNode(node);
  }
  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(""),
      ),
       drawer: customDrawer(appState.selectedIndex, selectedPlanet: null,),
      body: ArCoreView(
        onArCoreViewCreated: _onArViewCreated,
        enableTapRecognizer: true,
        enablePlaneRenderer: true,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;


  }


}


/*void _onArCoreViewCreated(ArCoreController controller){
arCoreController = controller;
_loadPlanetModel();
_buildPlanetButton('earth');



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
  }*/



