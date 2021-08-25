import 'package:spacegl/src/objects/vbo.dart';
import 'package:spacegl/src/space.dart';

abstract class VAO {
  final Space space;
  List<VBO> vbos = [];

  VAO(this.space);

  void bind() => space.bindVAO(this);

  void unbindVAO() => space.unbindVAO();

  void destroy() => space.destroyVAO(this);

  void addVBO(VBO vbo) => space.addVBOToVAO(vao: this, vbo: vbo);
}
