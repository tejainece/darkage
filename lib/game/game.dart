import 'dart:html';
import 'dart:async';
import 'dart:math' as math;
import 'package:threejs_facade/three.dart';

class Game {
  WebGLRenderer renderer;

  PerspectiveCamera camera;

  Scene scene;

  Game();

  void init() {
    scene = Scene();
    scene.background = 0xffffff;

    // Camera
    camera = PerspectiveCamera(
        75.0, window.innerWidth / window.innerHeight, 0.1, 10.0);
    camera.position.x = 0;
    camera.position.y = 0;
    camera.position.z = 30;
    camera.lookAt(0, 0, 0);
    scene.add(camera);

    // Terrain
    /*
    scene.add(Mesh(
        PlaneBufferGeometry(10000, 10000),
        MeshBasicMaterial(
            MeshBasicMaterialParameters(color: 0x0000ff, side: DoubleSide))));
            */

    scene.add(Mesh(
        BoxBufferGeometry(5, 5, 5),
        MeshBasicMaterial(
            MeshBasicMaterialParameters(color: 0xff0000, side: BackSide)))
      ..position.z = 0
      ..position.x = 0
      ..position.y = 0);

    // TODO

    final light = PointLight(0xFFFFFF);
    light.lookAt(0, 0, 0);
    light.position.z = 10.0;
    scene.add(light);

    renderer = WebGLRenderer();

    _resizeSub = window.onResize.listen((_) => onResize());
    onResize();

    document.body.children.add(renderer.domElement);
  }

  void tick(_) {
    window.requestAnimationFrame(tick);
    renderer.render(scene, camera);
  }

  void dispose() {
    if (_resizeSub != null) {
      _resizeSub.cancel();
      _resizeSub = null;
    }
  }

  StreamSubscription _resizeSub;

  void onResize() {
    renderer.setSize(window.innerWidth, window.innerHeight, true);
    camera.fov = 75.0;
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.near = 0.1;
    camera.far = 100.0;
  }
}
