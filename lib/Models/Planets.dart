

import 'package:vector_math/vector_math.dart';

class Planet {
  final String name;
  final String modelPath;
  final Vector3? scale; // Make it nullable

  Planet({required this.name, required this.modelPath, this.scale});
}
