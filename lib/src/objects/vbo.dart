import 'package:spacegl/src/objects/vao.dart';
import 'package:spacegl/src/space.dart';

abstract class VBO {
  final Space space;
  final int length;
  final VBOType type;
  List<double> data;

  VAO? vao;

  VBO(
    this.space, {
    required this.length,
    required this.type,
    required this.data,
  });

  void bind() => space.bindVBO(this);
  void unbind() => space.unbindVBO();

  void addToVAO(VAO vao) => vao.addVBO(this);

  void destroy() => space.destroyVBO(this);
}

enum VBOType { STATIC, DYNAMIC }
