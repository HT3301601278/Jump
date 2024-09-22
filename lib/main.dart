import 'package:flutter/material.dart';
import 'game/game_screen.dart';
import 'widgets/start_menu.dart';

void main() {
  runApp(const JumpGameApp());
}

class JumpGameApp extends StatelessWidget {
  const JumpGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '跳一跳游戏',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StartMenu(),
    );
  }
}