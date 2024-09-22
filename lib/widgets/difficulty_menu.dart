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
      backgroundColor: Color(0xFF1A2B3C),
      appBar: AppBar(
        title: Text('自定义模式'),
        backgroundColor: Color(0xFF64B5F6),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('平台移动速度', style: TextStyle(color: Colors.white)),
            Slider(
              value: _platformSpeed,
              min: 1.0,
              max: 5.0,
              divisions: 4,
              label: _platformSpeed.toString(),
              activeColor: Color(0xFF4CAF50),
              inactiveColor: Color(0xFF4CAF50).withOpacity(0.3),
              onChanged: (value) {
                setState(() {
                  _platformSpeed = value;
                });
              },
            ),
            Text('小球下降速度', style: TextStyle(color: Colors.white)),
            Slider(
              value: _gravity,
              min: 0.1,
              max: 0.5,
              divisions: 4,
              label: _gravity.toStringAsFixed(1),
              activeColor: Color(0xFF4CAF50),
              inactiveColor: Color(0xFF4CAF50).withOpacity(0.3),
              onChanged: (value) {
                setState(() {
                  _gravity = double.parse(value.toStringAsFixed(1));
                });
              },
            ),
            CheckboxListTile(
              title: Text('允许连续跳跃', style: TextStyle(color: Colors.white)),
              value: _allowContinuousJump,
              activeColor: Color(0xFF4CAF50),
              checkColor: Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  _allowContinuousJump = value!;
                });
              },
            ),
            ElevatedButton(
              child: Text('开始游戏'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF64B5F6),
                foregroundColor: Colors.white,
              ),
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