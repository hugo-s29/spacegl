import 'package:spacegl/src/space.dart';

abstract class Shader {
  ShaderType type;
  String code;
  Space space;

  Shader(
    this.space, {
    required this.type,
    required this.code,
  });
}

enum ShaderType {
  VERTEX_SHADER,
  FRAGMENT_SHADER,
}
