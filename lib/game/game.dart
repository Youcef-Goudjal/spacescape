import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:spacescape/game/enemy_manager.dart';
import 'package:spacescape/game/player.dart';

import 'core/core.dart';

class SpacescapeGame extends FlameGame
    with HasDraggables, HasCollisionDetection, HasKeyboardHandlerComponents {
  late Player _player;

  late SpriteSheet spriteSheet;

  @override
  Future<void>? onLoad() async {
    super.onLoad();
    // Makes the game use a fixed resolution irrespective of the windows size.
    // camera.viewport = FixedResolutionViewport(Vector2(540, 960));
    // load assets
    await images.loadAll([
      GameAssets.simpleSpaceSheet,
    ]);
    spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: images.fromCache(GameAssets.simpleSpaceSheet),
      columns: 8,
      rows: 6,
    );
    // joystick component on the left
    final joystick = JoystickComponent(
      position: Vector2(70, size.y - 70),
      background: CircleComponent(
        radius: 60,
        paint: Paint()..color = Colors.white.withOpacity(0.5),
      ),
      knob: CircleComponent(radius: 30),
    );
    add(joystick);
    //player
    _player = Player(
      joystick: joystick,
      sprite: spriteSheet.getSpriteById(4),
      size: Vector2(64, 64),
      position: canvasSize / 2,
    );
    add(_player);
    // enemies
    final enemeyManager = EnemeyManager(spriteSheet: spriteSheet);
    add(enemeyManager);
  }
}
