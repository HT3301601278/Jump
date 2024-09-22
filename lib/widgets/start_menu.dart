import 'package:flutter/material.dart';
import '../game/game_screen.dart';
import 'difficulty_menu.dart';

class StartMenu extends StatelessWidget {
  const StartMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('简单模式'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen(allowContinuousJump: true)),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('自定义模式'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DifficultyMenu()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}