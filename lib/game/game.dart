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

    scene.background = 0x00ff00;

    // Camera
    camera = PerspectiveCamera(75.0, window.innerWidth / window.innerHeight, 0.1, 10.0);
    scene.add(camera);

    // Terrain
    /*
    scene.add(Mesh(
        PlaneBufferGeometry(10000, 10000),
        MeshBasicMaterial(
            MeshBasicMaterialParameters(color: 0x0000ff, side: DoubleSide))));
            */

    scene.add(Mesh(BoxBufferGeometry(5, 5, 5), MeshBasicMaterial())
      ..position.z = 0);

    // TODO

    final light = PointLight(0xFFFFFF);
    light.position.z = 10.0;
    scene.add(light);

    renderer = WebGLRenderer();

    _resizeSub = window.onResize.listen((_) => onResize());
    onResize();

    document.body.children.add(renderer.domElement);
  }

  void tick(_) {
    window.requestAnimationFrame(tick);
    renderer.render(scene, camera, null, true);
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
    camera.far = 10.0;
  }
}
