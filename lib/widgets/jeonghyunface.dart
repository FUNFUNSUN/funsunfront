import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class JeonghyunFace extends StatelessWidget {
  JeonghyunFace({Key? key}) : super(key: key);

  final bgAudio = AudioPlayer();

  void playBackgroundMusic() {
    bgAudio.play(
      AssetSource('audio/circus.mp3'),
    );
    // bgAudio.onPlayerComplete.listen((event) {
    //   bgAudio.play(
    //     AssetSource('audio/circus.mp3'),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    playBackgroundMusic();
    return const Scaffold(
      body: Center(
        child: AnimatedImageRotation(),
      ),
    );
  }
}

class AnimatedImageRotation extends StatefulWidget {
  const AnimatedImageRotation({super.key});

  @override
  _AnimatedImageRotationState createState() => _AnimatedImageRotationState();
}

class _AnimatedImageRotationState extends State<AnimatedImageRotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // 회전주기
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: -1.0).animate(_controller), // 음수->반시계
      child: Transform.scale(
        scale: 2.5,
        child: Image.asset(
          'assets/images/andre.jpg',
        ),
      ),
    );
  }
}
