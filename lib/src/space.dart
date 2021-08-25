import 'package:spacegl/src/objects/vao.dart';
import 'package:spacegl/src/objects/vbo.dart';
import 'package:spacegl/src/shaders/shader.dart';
import 'package:spacegl/src/shaders/shader_program.dart';

abstract class Space {
  VAO createVAO();
  VBO createVBO({
    required int length,
    required VBOType type,
    required List<double> data,
  });

  void bindVAO([VAO? vao]);
  void bindVBO([VBO? vbo]);

  void unbindVAO() => bindVAO();
  void unbindVBO() => bindVBO();

  void destroyVAO(VAO vao);
  void destroyVBO(VBO vbo);

  void addVBOToVAO({required VAO vao, required VBO vbo});
  void setVBOAttribute({
    required ShaderProgram shaderProgram,
    required VBO vbo,
  });

  void clearDisplay({
    required double r,
    required double g,
    required double b,
    double a = 1,
    bool clearDepthBuffer = true,
  });

  Shader createShader({
    required ShaderType type,
    required String code,
  });

  Shader createVertexShader(String code) =>
      createShader(type: ShaderType.VERTEX_SHADER, code: code);

  Shader createFragmentShader(String code) =>
      createShader(type: ShaderType.FRAGMENT_SHADER, code: code);

  ShaderProgram createShaderProgram({
    required Shader fragmentShader,
    required Shader vertexShader,
  });
}
