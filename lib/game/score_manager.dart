import 'package:flutter/material.dart';

class ScoreManager {
  int score = 0;

  void update(Offset playerPosition) {
    // 简单示例：根据Y轴位置增加分数
    score = (score + 1).clamp(0, 1000000).toInt();
  }
}