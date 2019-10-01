import 'dart:html';

import 'package:darkage/game/game.dart';

void main() {
  final game = Game();

  game.init();
  game.tick(0);
}

