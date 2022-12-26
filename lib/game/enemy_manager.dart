import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/sprite.dart';
import 'package:spacescape/game/enemy.dart';

class EnemeyManager extends Component with HasGameReference {
  late Timer timer = Timer(
    1,
    onTick: _spawnEnemy,
    repeat: true,
  );
  final SpriteSheet spriteSheet;
  Random random = Random();
  EnemeyManager({required this.spriteSheet});
  @override
  void onMount() {
    super.onMount();
    timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
  }

  void _spawnEnemy() {
    Vector2 initialSize = Vector2(64, 64);
    Vector2 position = Vector2(random.nextDouble() * game.canvasSize.x, 0);
    position.clamp(
        Vector2.zero() + initialSize / 2, game.canvasSize - initialSize / 2);
    Enemy enemy = Enemy(
      position: position,
      sprite: spriteSheet.getSpriteById(11),
      size: initialSize,
    );
    add(enemy);
  }

  @override
  void onRemove() {
    super.onRemove();
    timer.stop();
  }
}
