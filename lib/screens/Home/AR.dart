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



  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();

  }

  void _onArViewCreated(ArCoreController controller) {
    arCoreController = controller;

    displayearthmap(arCoreController);

  }

  displayearthmap(ArCoreController controller) async {
    final ByteData earthTextureBytes = await rootBundle.load("assets/3d_objects/earth.glb");

    // Print the length of the loaded texture bytes
    print("***************************************Texture Byte Length: ${earthTextureBytes.lengthInBytes}");


    final materials = ArCoreMaterial(
      color: Colors.blue ,
      textureBytes: earthTextureBytes.buffer.asUint8List(),
    );

    final sphere = ArCoreSphere(
      materials: [materials],
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector64.Vector3(0, 0, 1.5),
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




}





