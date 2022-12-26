import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';

import 'package:flutter/services.dart';
import 'package:spacescape/game/bullet.dart';

import 'core/core.dart';
import 'game.dart';

class Player extends SpriteComponent
    with HasGameReference<SpacescapeGame>, CollisionCallbacks, KeyboardHandler {
  // player joystick
  final JoystickComponent joystick;
  final double _maxSpeed = 300;
  late final Vector2 _lastSize = size.clone();
  late final Transform2D _lastTransform = transform.clone();

  Player({
    required this.joystick,
    super.sprite,
    super.position,
    super.size,
    super.anchor = Anchor.center,
  });

  @override
  void onMount() {
    super.onMount();
    final shape = CircleHitbox(radius: 0.8);
    add(shape);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!joystick.delta.isZero() && activeCollisions.isEmpty) {
      _lastSize.setFrom(size);
      _lastTransform.setFrom(transform);
      position.add(joystick.relativeDelta * _maxSpeed * dt);
      angle = joystick.delta.screenAngle();
    }
    if (!keyboardDelta.isZero() && activeCollisions.isEmpty) {
      position.add(keyboardDelta * _maxSpeed * dt);
      angle = keyboardDelta.screenAngle();
    }
    position.clamp(Vector2.zero() + size / 2, game.size - size / 2);
  }

  Vector2 keyboardDelta = Vector2.zero();

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    keyboardDelta.setZero();

    if (!keysWatched.contains(event.logicalKey)) return true;

    if (event is RawKeyDownEvent &&
        !event.repeat &&
        event.logicalKey == LogicalKeyboardKey.space) {
      // shoot!!!!
      shoot();
    }
    if (containsKeys(keysPressed, up)) {
      // move up
      keyboardDelta.y = -1;
    }
    if (containsKeys(keysPressed, down)) {
      // move down
      keyboardDelta.y = 1;
    }
    if (containsKeys(keysPressed, right)) {
      // move right
      keyboardDelta.x = 1;
    }
    if (containsKeys(keysPressed, left)) {
      // move left
      keyboardDelta.x = -1;
    }

    // Handeled keyboard input
    return false;
  }

  void shoot() {
    Bullet bullet = Bullet(
      sprite: game.spriteSheet.getSpriteById(28),
      size: Vector2(64, 64),
      position: position.clone(),
      anchor: Anchor.center,
      direction: Vector2(sin(angle), cos(angle + pi)),
    );
    game.add(bullet);
  }
}
