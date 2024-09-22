import 'package:flutter/material.dart';

class Player {
  Offset position;
  double size;
  double velocityY;
  double gravity;
  double maxHeight;
  bool canJump = true;

  Player({
    this.position = const Offset(100, 300),
    this.size = 50.0,
    this.velocityY = 0.0,
    this.gravity = 0.2,
    this.maxHeight = 100.0,
  });

  void jump(bool allowContinuousJump) {
    if (canJump || allowContinuousJump) {
      velocityY = -10.0;
      canJump = false;
    }
  }

  void update() {
    velocityY += gravity;
    double newY = position.dy + velocityY;
    if (newY < maxHeight) {
      newY = maxHeight;
      velocityY = 0;
    }
    position = Offset(position.dx, newY);
    
    if (velocityY == 0) {
      canJump = true;
    }
  }
}