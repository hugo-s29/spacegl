import 'dart:web_gl';

import 'package:spacegl/src/objects/vbo.dart';
import 'package:spacegl/src/space.dart';

class WebGLVBO extends VBO {
  Buffer buffer;

  WebGLVBO(
    Space space, {
    required int length,
    required VBOType type,
    required List<double> data,
    required this.buffer,
  }) : super(
          space,
          data: data,
          type: type,
          length: length,
        );
}
