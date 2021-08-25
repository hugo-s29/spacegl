import 'package:spacegl/src/shaders/shader.dart';
import 'package:spacegl/src/space.dart';

abstract class ShaderProgram {
  final Shader fragmentShader;
  final Shader vertexShader;
  final Space space;

  ShaderProgram(
    this.space, {
    required this.fragmentShader,
    required this.vertexShader,
  });
}
