import 'package:flutter/material.dart';

class PauseMenu extends StatelessWidget {
  final VoidCallback onResume;
  final VoidCallback onQuit;

  const PauseMenu({super.key, required this.onResume, required this.onQuit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('游戏暂停'),
      content: const Text('您已暂停游戏。'),
      actions: <Widget>[
        TextButton(
          child: const Text('继续游戏'),
          onPressed: onResume,
        ),
        TextButton(
          child: const Text('返回主页'),
          onPressed: onQuit,
        ),
      ],
    );
  }
}