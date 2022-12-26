import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:spacescape/game/enemy.dart';

class Bullet extends SpriteComponent with HasGameReference, CollisionCallbacks {
  final double _speed = 450;
  final Vector2 direction;
  Bullet({
    super.sprite,
    super.position,
    Vector2? direction,
    super.size,
    super.anchor = Anchor.center,
  }) : direction = direction ?? Vector2(0, -1);
  @override
  void update(double dt) {
    super.update(dt);
    position += direction * _speed * dt;

    // If bullet crosses the upper boundary of screen
    // mark it to be removed it from the game world.
    if (position.y < 0 && !isRemoving) {
      removeFromParent();
    }
  }

  @override
  void onMount() {
    super.onMount();
    // Adding a circular hitbox with radius as 0.4 times
    //  the smallest dimension of this components size.
    final shape = CircleHitbox.relative(
      0.4,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    // If the other Collidable is Enemy, remove this bullet.
    if (other is Enemy) {
      removeFromParent();
    }
  }
}
