import 'package:flutter/material.dart';
import '../game/game_screen.dart';
import '../widgets/start_menu.dart';

class GameOver extends StatelessWidget {
  final int score;
  final double platformSpeed;
  final bool allowContinuousJump;
  final double gravity;

  const GameOver({
    super.key,
    required this.score,
    required this.platformSpeed,
    required this.allowContinuousJump,
    required this.gravity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('游戏结束', style: TextStyle(fontSize: 36, color: Colors.red)),
            SizedBox(height: 20),
            Text('分数: $score', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text('重新开始'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(
                      platformSpeed: platformSpeed,
                      allowContinuousJump: allowContinuousJump,
                      gravity: gravity,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text('返回主页'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StartMenu()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}