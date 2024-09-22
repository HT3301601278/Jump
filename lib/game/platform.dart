import 'package:flutter/material.dart';

class Platform {
  Offset position;
  double width;
  double height;
  double velocityX; // 新增：水平速度

  Platform({
    required this.position,
    this.width = 100.0,
    this.height = 20.0,
    this.velocityX = 2.0, // 默认向左移动的速度
  });

  // 更新平台位置
  void update() {
    position = Offset(position.dx - velocityX, position.dy);
  }

  // 生成初始平台
  static List<Platform> generateInitialPlatforms() {
    return [
      Platform(position: Offset(100, 300), height: 15 + (DateTime.now().millisecondsSinceEpoch % 15)),
      Platform(position: Offset(250, 400), height: 15 + (DateTime.now().millisecondsSinceEpoch % 15)),
      Platform(position: Offset(400, 350), height: 15 + (DateTime.now().millisecondsSinceEpoch % 15)),
      // 添加更多平台
    ];
  }

  // 生成新的平台，根据当前平台的位置生成
  static Platform generateNewPlatform(double lastPlatformX) {
    double newX = lastPlatformX + 150 + (100 * (0.5 + (DateTime.now().millisecondsSinceEpoch % 100) / 100));
    double newY = 300 + (DateTime.now().millisecondsSinceEpoch % 200);
    double randomHeight = 10.0 + (DateTime.now().millisecondsSinceEpoch % 20); // 随机高度在10到30之间
    return Platform(
      position: Offset(newX, newY),
      height: randomHeight,
    );
  }
}