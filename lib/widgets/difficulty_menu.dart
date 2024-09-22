import 'package:flutter/material.dart';
import '../game/game_screen.dart';

class DifficultyMenu extends StatefulWidget {
  const DifficultyMenu({Key? key}) : super(key: key);

  @override
  _DifficultyMenuState createState() => _DifficultyMenuState();
}

class _DifficultyMenuState extends State<DifficultyMenu> {
  double _platformSpeed = 2.0;
  double _gravity = 0.2;
  bool _allowContinuousJump = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('自定义模式')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('平台移动速度'),
            Slider(
              value: _platformSpeed,
              min: 1.0,
              max: 5.0,
              divisions: 4,
              label: _platformSpeed.toString(),
              onChanged: (value) {
                setState(() {
                  _platformSpeed = value;
                });
              },
            ),
            const Text('小球下降速度'),
            Slider(
              value: _gravity,
              min: 0.1,
              max: 0.5,
              divisions: 4,
              label: _gravity.toStringAsFixed(1),
              onChanged: (value) {
                setState(() {
                  _gravity = double.parse(value.toStringAsFixed(1));
                });
              },
            ),
            CheckboxListTile(
              title: const Text('允许连续跳跃'),
              value: _allowContinuousJump,
              onChanged: (bool? value) {
                setState(() {
                  _allowContinuousJump = value!;
                });
              },
            ),
            ElevatedButton(
              child: const Text('开始游戏'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(
                      platformSpeed: _platformSpeed,
                      allowContinuousJump: _allowContinuousJump,
                      gravity: _gravity,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}