
import 'package:flutter/material.dart';
import 'package:sign_in/Models/Planets.dart';
import 'package:vector_math/vector_math.dart';

import 'AR.dart';



class PlanetSelectionPage extends StatelessWidget {
  final List<Planet> planets = [
    Planet(name: 'Earth', modelPath: 'assets/earth.glb', scale: Vector3(0.2, 0.2, 0.2)),

    // Add more planets...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select a Planet')),
      body: ListView.builder(
        itemCount: planets.length,
        itemBuilder: (context, index) {
          final planet = planets[index];
          return ListTile(
            title: Text(planet.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AR(planet: planet)),
              );
            },
          );
        },
      ),
    );
  }
}
