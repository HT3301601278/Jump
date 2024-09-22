import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'player.dart';
import 'platform.dart';
import 'game_logic.dart';
import 'score_manager.dart';
import '../widgets/game_over.dart';
import '../widgets/pause_menu.dart';
import '../widgets/start_menu.dart';

class GameScreen extends StatefulWidget {
  final double platformSpeed;
  final bool allowContinuousJump;
  final double gravity;

  const GameScreen({
    Key? key,
    this.platformSpeed = 2.0,
    this.allowContinuousJump = false,
    this.gravity = 0.2,
  }) : super(key: key);

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
        gravity: widget.gravity,
      );
    } else {
      _player = Player(maxHeight: 100.0, gravity: widget.gravity);
    }
    _audioPlayer = AudioPlayer();
    _gameLogic = GameLogic(_player, _platforms, platformSpeed: widget.platformSpeed, allowContinuousJump: widget.allowContinuousJump);
    _scoreManager = ScoreManager();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(_update);
    _controller.repeat();
    
    _preloadAudio();
  }

  Future<void> _preloadAudio() async {
    try {
      await _audioPlayer.setSource(AssetSource('sounds/jump.mp3'));
      await _audioPlayer.setPlaybackRate(1.0);
      print('音频已预加载，播放速度已调整');
    } catch (e) {
      print('预加载音频时出错: $e');
    }
  }

  void _update() {
    if (!_isPaused) {
      _gameLogic.update();
      _scoreManager.update(_player.position);
      setState(() {
        _platforms = _gameLogic.platforms;
      });
      if (_gameLogic.isGameOver()) {
        _controller.stop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GameOver(score: _scoreManager.score, platformSpeed: widget.platformSpeed, allowContinuousJump: widget.allowContinuousJump, gravity: widget.gravity)),
        );
      }
    }
  }

  void _onTap() {
    _player.jump(widget.allowContinuousJump);
    _audioPlayer.stop();
    _audioPlayer.seek(Duration.zero);
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
      builder: (BuildContext context) {
        return PauseMenu(
          onResume: () {
            setState(() {
              _isPaused = false;
              _controller.repeat();
            });
            Navigator.of(context).pop();
          },
          onQuit: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const StartMenu()),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Scaffold(
        backgroundColor: Color(0xFF1A2B3C),
        body: Stack(
          children: [
            ..._platforms.map((platform) => Positioned(
              left: platform.position.dx,
              top: platform.position.dy,
              child: Container(
                width: platform.width,
                height: platform.height,
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            )),
            Positioned(
              left: _player.position.dx,
              top: _player.position.dy,
              child: Transform(
                transform: Matrix4.identity()
                  ..scale(_player.scale)
                  ..rotateZ(_player.rotation),
                alignment: Alignment.center,
                child: Container(
                  width: _player.size,
                  height: _player.size,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF9800),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: Text(
                '分数: ${_scoreManager.score}',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: Icon(Icons.pause, color: Colors.white),
                onPressed: _pauseGame,
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