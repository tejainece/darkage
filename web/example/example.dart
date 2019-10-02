import 'dart:html';
import 'dart:math' as Math;
import 'package:threejs_facade/three.dart';

Math.Random rand = Math.Random();

DivElement container;
WebGLRenderer renderer;
Scene scene;
OrthographicCamera camera;

Object3D poptart;

num windowHalfX = window.innerWidth / 2;
num windowHalfY = window.innerHeight / 2;

num deltaSum = 0;
num tick = 0;
num frame = 0;
bool running = true;

void main() {
  init();
  animate(0);
}

void init() {
  container = DivElement();
  document.body.children.add(container);

  /*
  camera = PerspectiveCamera(
      45.0, window.innerWidth / window.innerHeight, 0.1, 10000.0);
  camera.position.z = 30.0;
  camera.position.x = 0.0;
  camera.position.y = 0.0;
  */

  scene = Scene();
  // TODO: FogExp2 does not inherit correctly.
  scene.fog = FogExp2(0x003366, 0.0095);

  final aspect = window.innerWidth / window.innerHeight;
  final d = 20;
  camera = OrthographicCamera(-d * aspect, d * aspect, d, -d, 1, 1000);
  camera.position.x = 40;
  camera.position.y = 40;
  camera.position.z = 40;
  camera.lookAt(scene.position);

  //POPTART
  poptart = Object3D();
  poptart.add(Mesh(BoxBufferGeometry(1, 1, 1),
      MeshLambertMaterial(MeshLambertMaterialParameters(color: 0xffcc99))));

  poptart.position.x = 0;
  poptart.position.y = 0;
  scene.add(poptart);


  final terrain = Object3D();
  terrain.add(Mesh(PlaneBufferGeometry(10, 10),
      MeshLambertMaterial(MeshLambertMaterialParameters(color: 0xff0000))));
  terrain.position.x = 0;
  terrain.position.y = 0;
  terrain.position.z = 0;
  scene.add(terrain);

  final worldAxis = AxesHelper(20);
  scene.add(worldAxis);

  var pointLight = PointLight(0xFFFFFF);
  pointLight.position.z = 1000.0;
  scene.add(pointLight);

  renderer = WebGLRenderer();
  renderer.setSize(window.innerWidth, window.innerHeight, true);
  container.nodes.add(renderer.domElement);
}

void animate(num t) {
  window.requestAnimationFrame(animate);
  render(t);
}

void render(num t) {
  camera.lookAt(scene.position);
  renderer.render(scene, camera, null, false);
}
