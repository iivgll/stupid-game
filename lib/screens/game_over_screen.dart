import 'package:flappy_bird_game/game/assets.dart';
import 'package:flappy_bird_game/game/flappy_bird_game.dart';
import 'package:flappy_bird_game/game/styles.dart';
import 'package:flappy_bird_game/screens/widgets/heart_button.dart';
import 'package:flutter/material.dart';

import '../services/log_in_firebase.dart';

class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game;

  const GameOverScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.black38,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Score: ${game.bird.score}',
                style: AppTextStyles.heading.copyWith(fontSize: 60),
              ),
              const SizedBox(height: 20),
              Image.asset(Assets.gameOver),
              const SizedBox(height: 30),
              HeartbeatButton(
                label: 'Restart',
                onTap: onRestart,
              ),
            ],
          ),
        ),
      );

  void onRestart() {
    ServiceLog.sendAnalyticsEvent(
      'restart_game',
      {
        'score': '${game.bird.score}',
      },
    );
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
