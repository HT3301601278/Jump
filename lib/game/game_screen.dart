import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'player.dart';
import 'platform.dart';
import 'game_logic.dart';
import 'score_manager.dart';
import '../widgets/game_over.dart';
import '../widgets/pause_menu.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Player _player;
  late List<Platform> _platforms;
  late GameLogic _gameLogic;
  late ScoreManager _scoreManager;
  bool _isPaused = false;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _platforms = Platform.generateInitialPlatforms();
    
    if (_platforms.isNotEmpty) {
      _player = Player(
        position: Offset(
          _platforms.first.position.dx,
          _platforms.first.position.dy - 50.0,
        ),
        maxHeight: 100.0,
      );
    } else {
      _player = Player(maxHeight: 100.0);
    }

    _gameLogic = GameLogic(_player, _platforms, platformSpeed: 2.0);
    _scoreManager = ScoreManager();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(_update);
    _controller.repeat();

    _audioPlayer = AudioPlayer();
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    await _audioPlayer.setSource(AssetSource('sounds/jump.mp3'));
  }

  void _update() {
    if (!_isPaused) {
      setState(() {
        _gameLogic.update();
        _scoreManager.update(_player.position);
        if (_gameLogic.isGameOver()) {
          _controller.stop();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => GameOver(score: _scoreManager.score)),
          );
        }
      });
    }
  }

  void _onTap() {
    _player.jump();
    _audioPlayer.stop();
    _audioPlayer.play(AssetSource('sounds/jump.mp3'));
  }

  void _pauseGame() {
    setState(() {
      _isPaused = true;
      _controller.stop();
    });
    _showPauseMenu();
  }

  void _showPauseMenu() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PauseMenu(
          onResume: () {
            Navigator.of(context).pop();
            _resumeGame();
          },
          onQuit: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        );
      },
    );
  }

  void _resumeGame() {
    setState(() {
      _isPaused = false;
      _controller.repeat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: Colors.lightBlueAccent),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.pause, color: Colors.white, size: 30),
                onPressed: _pauseGame,
              ),
            ),
            ..._platforms.map((platform) => Positioned(
                  left: platform.position.dx,
                  top: platform.position.dy,
                  child: Container(
                    width: platform.width,
                    height: platform.height,
                    color: Colors.green,
                  ),
                )),
            Positioned(
              left: _player.position.dx,
              top: _player.position.dy,
              child: Container(
                width: _player.size,
                height: _player.size,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: Text(
                '分数: ${_scoreManager.score}',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}