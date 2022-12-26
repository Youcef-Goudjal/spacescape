import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:spacescape/game/bullet.dart';
import 'package:spacescape/game/player.dart';

class Enemy extends SpriteComponent with HasGameReference, CollisionCallbacks {
  final double speed = 250;
  // This direction in which this Enemy will move.
  // Defaults to vertically downwards.
  final Vector2 direction;
  Enemy({
    super.sprite,
    super.position,
    Vector2? direction,
    super.size,
    super.anchor = Anchor.center,
  }) : direction = direction ?? Vector2(0, 1);
  @override
  void onMount() {
    super.onMount();
    // Adding a circular hitbox with radius as 0.8 times
    // the smallest dimension of this components size.
    final shape = CircleHitbox.relative(
      0.8,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += Vector2(0, 1) * speed * dt;
    if (position.y > game.canvasSize.y && !isRemoving) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Bullet) {
      removeFromParent();
    } else if (other is Player) {
      print("player hited");
    }
  }
}
