import 'dart:web_gl' as web_gl;

import 'package:spacegl/src/shaders/shader.dart';
import 'package:spacegl/src/shaders/shader_program.dart';
import 'package:spacegl/src/webgl/webgl_space.dart';

class WebGLShader extends Shader {
  web_gl.Shader webglShader;

  WebGLShader(
    WebGLSpace space, {
    required ShaderType type,
    required String code,
    required this.webglShader,
  }) : super(space, type: type, code: code);
}

class WebGLShaderProgram extends ShaderProgram {
  @override
  final WebGLShader fragmentShader;

  @override
  final WebGLShader vertexShader;

  final web_gl.Program webglProgram;

  WebGLShaderProgram(
    WebGLSpace space, {
    required this.fragmentShader,
    required this.vertexShader,
    required this.webglProgram,
  }) : super(
          space,
          fragmentShader: fragmentShader,
          vertexShader: vertexShader,
        );
}
