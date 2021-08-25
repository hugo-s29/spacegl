import 'dart:html' show CanvasElement;
import 'dart:web_gl' show WebGL, RenderingContext;

import 'package:spacegl/src/objects/vao.dart';
import 'package:spacegl/src/objects/vbo.dart';
import 'package:spacegl/src/shaders/shader.dart';
import 'package:spacegl/src/shaders/shader_program.dart';
import 'package:spacegl/src/space.dart';
import 'package:spacegl/src/webgl/webgl_shaders.dart';
import 'package:spacegl/src/webgl/webgl_vao.dart';
import 'package:spacegl/src/webgl/webgl_vbo.dart';

class WebGLSpace extends Space {
  final CanvasElement canvas;
  final RenderingContext gl;

  WebGLSpace(
    this.canvas, {
    bool alpha = true,
    bool antialias = true,
  }) : gl = canvas.getContext3d(
          alpha: alpha,
          antialias: antialias,
        );

  @override
  WebGLVAO createVAO() => WebGLVAO(this);

  @override
  WebGLVBO createVBO({
    required int length,
    required VBOType type,
    required List<double> data,
  }) {
    final buffer = gl.createBuffer();
    return WebGLVBO(
      this,
      length: length,
      type: type,
      data: data,
      buffer: buffer,
    );
  }

  @override
  void bindVAO([VAO? vao]) {}

  @override
  void bindVBO([VBO? vbo]) {
    assert(vbo is WebGLVBO?);

    if (vbo != null) {
      gl.bindBuffer(WebGL.ARRAY_BUFFER, (vbo as WebGLVBO).buffer);
    } else {
      gl.bindBuffer(WebGL.ARRAY_BUFFER, null);
    }
  }

  @override
  void destroyVAO(VAO vao) {
    throw UnimplementedError();
  }

  @override
  void destroyVBO(VBO vbo) {
    assert(vbo is WebGLVBO);

    gl.deleteBuffer((vbo as WebGLVBO).buffer);
  }

  @override
  void addVBOToVAO({required VAO vao, required VBO vbo}) {
    assert(vao is WebGLVAO);
    assert(vbo is WebGLVBO);

    vao.vbos.add(vbo);
  }

  @override
  void setVBOAttribute({
    required ShaderProgram shaderProgram,
    required VBO vbo,
  }) {
    assert(shaderProgram is WebGLShaderProgram);
    assert(vbo is WebGLVBO);
  }

  @override
  void clearDisplay({
    required double r,
    required double g,
    required double b,
    double a = 1,
    bool clearDepthBuffer = true,
  }) {
    final mask = WebGL.COLOR_BUFFER_BIT |
        (clearDepthBuffer ? WebGL.DEPTH_BUFFER_BIT : 0);

    gl.clearColor(r * 255, g * 255, b * 255, a);
    gl.clear(mask);
  }

  @override
  WebGLShader createShader({required ShaderType type, required String code}) {
    final shader = gl.createShader(getShaderType(type));

    gl.shaderSource(shader, code);
    gl.compileShader(shader);
    if (gl.getShaderParameter(shader, WebGL.COMPILE_STATUS) == false) {
      final info = gl.getShaderInfoLog(shader);
      gl.deleteShader(shader);
      throw 'Couldn\'t compile shader $info';
    }

    return WebGLShader(
      this,
      type: type,
      code: code,
      webglShader: shader,
    );
  }

  int getShaderType(ShaderType type) {
    if (type == ShaderType.FRAGMENT_SHADER) {
      return WebGL.FRAGMENT_SHADER;
    } else if (type == ShaderType.VERTEX_SHADER) {
      return WebGL.VERTEX_SHADER;
    } else {
      throw 'Unknown shader type $type';
    }
  }

  @override
  WebGLShaderProgram createShaderProgram({
    required Shader fragmentShader,
    required Shader vertexShader,
  }) {
    assert(fragmentShader is WebGLShader);
    assert(vertexShader is WebGLShader);

    final program = gl.createProgram();

    gl.attachShader(program, (fragmentShader as WebGLShader).webglShader);
    gl.attachShader(program, (vertexShader as WebGLShader).webglShader);
    gl.linkProgram(program);

    if (gl.getProgramParameter(program, WebGL.LINK_STATUS) == false) {
      final info = gl.getProgramInfoLog(program);
      gl.deleteProgram(program);
      throw 'Couldn\'t compile shader program $info';
    }

    return WebGLShaderProgram(
      this,
      fragmentShader: fragmentShader,
      vertexShader: vertexShader,
      webglProgram: program,
    );
  }
}
