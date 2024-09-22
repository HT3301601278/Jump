import 'package:flutter/material.dart';
import 'player.dart';
import 'platform.dart';

class GameLogic {
  final Player player;
  final List<Platform> platforms;
  double platformSpeed; // 平台移动速度

  GameLogic(this.player, this.platforms, {this.platformSpeed = 2.0});

  void update() {
    player.update();
    _movePlatforms();
    _checkCollision();
    _generatePlatforms();
  }

  // 移动平台
  void _movePlatforms() {
    for (var platform in platforms) {
      platform.velocityX = platformSpeed;
      platform.update();
    }

    // 移除离开屏幕左侧的平台
    platforms.removeWhere((platform) => platform.position.dx + platform.width < 0);
  }

  void _checkCollision() {
    for (var platform in platforms) {
      if (player.position.dy + player.size >= platform.position.dy &&
          player.position.dy + player.size <= platform.position.dy + platform.height &&
          player.position.dx + player.size > platform.position.dx &&
          player.position.dx < platform.position.dx + platform.width) {
        player.velocityY = 0.0;
        player.position = Offset(player.position.dx, platform.position.dy - player.size);
      }
    }
  }

  void _generatePlatforms() {
    if (platforms.isEmpty) return;

    Platform lastPlatform = platforms.last;
    double screenWidth = 400; // 假设屏幕宽度为400

    while (lastPlatform.position.dx + lastPlatform.width < screenWidth * 1.5) {
      Platform newPlatform = Platform.generateNewPlatform(lastPlatform.position.dx);
      platforms.add(newPlatform);
      lastPlatform = newPlatform;
    }
  }

  bool isGameOver() {
    return player.position.dy > 600; // 假设屏幕高度为600
  }
}