import 'package:flutter/material.dart';
import 'player.dart';
import 'platform.dart';

class GameLogic {
  final Player player;
  final List<Platform> platforms;
  double platformSpeed;
  bool allowContinuousJump;

  GameLogic(this.player, this.platforms, {this.platformSpeed = 2.0, this.allowContinuousJump = false});

  void update() {
    player.update();
    _movePlatforms();
    _checkCollision();
    _generatePlatforms();
  }

  void _movePlatforms() {
    for (var platform in platforms) {
      platform.velocityX = platformSpeed;
      platform.update();
    }

    platforms.removeWhere((platform) => platform.position.dx + platform.width < 0);
  }

  void _checkCollision() {
    bool isOnPlatform = false;
    for (var platform in platforms) {
      if (player.position.dy + player.size >= platform.position.dy &&
          player.position.dy + player.size <= platform.position.dy + platform.height &&
          player.position.dx + player.size > platform.position.dx &&
          player.position.dx < platform.position.dx + platform.width) {
        player.velocityY = 0.0;
        player.position = Offset(player.position.dx, platform.position.dy - player.size);
        isOnPlatform = true;
        break;
      }
    }
    player.canJump = isOnPlatform || allowContinuousJump;
  }

  void _generatePlatforms() {
    if (platforms.isEmpty) return;

    Platform lastPlatform = platforms.last;
    double screenWidth = 400;

    while (lastPlatform.position.dx + lastPlatform.width < screenWidth * 1.5) {
      Platform newPlatform = Platform.generateNewPlatform(lastPlatform.position.dx);
      platforms.add(newPlatform);
      lastPlatform = newPlatform;
    }
  }

  bool isGameOver() {
    return player.position.dy > 600;
  }
}