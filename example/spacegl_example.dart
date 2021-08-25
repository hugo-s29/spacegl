import 'dart:html';

import 'package:spacegl/spacegl_webgl.dart';

void main() {
  final canvas = document.querySelector('canvas') as CanvasElement;
  final space = WebGLSpace(canvas);

  final vertexShader = space.createVertexShader('');
  final fragmentShader = space.createFragmentShader('');
  final program = space.createShaderProgram(
    fragmentShader: fragmentShader,
    vertexShader: vertexShader,
  );
}
