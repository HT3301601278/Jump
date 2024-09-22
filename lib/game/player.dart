import 'package:flutter/material.dart';
import 'dart:math' as math;

class Player {
  Offset position;
  double size;
  double velocityY;
  double gravity;
  double maxHeight;
  bool canJump = true;
  double scale = 1.0;
  double rotation = 0.0;

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

    // 动画逻辑
    if (velocityY < 0) {
      // 上升阶段
      scale = 1.0 + (velocityY / 20).abs();
      rotation += 0.1;
    } else if (velocityY > 0) {
      // 下降阶段
      scale = 1.0 - (velocityY / 20).abs();
      rotation -= 0.1;
    } else {
      // 静止状态
      scale = 1.0;
      rotation = 0.0;
    }

    // 限制缩放和旋转范围
    scale = scale.clamp(0.8, 1.2);
    rotation = rotation.clamp(-0.3, 0.3);
  }
}