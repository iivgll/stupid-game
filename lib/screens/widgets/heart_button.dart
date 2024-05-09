import 'dart:async';

import 'package:flutter/material.dart';

import '../../game/styles.dart';

class HeartbeatButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  HeartbeatButton({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  _HeartbeatButtonState createState() => _HeartbeatButtonState();
}

class _HeartbeatButtonState extends State<HeartbeatButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _inactivityTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _resetTimer();
  }

  void _resetTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(Duration(seconds: 5), () {
      _controller.forward(); // Запуск анимации
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _inactivityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _resetTimer();
        _controller.reset();
        widget.onTap();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(widget.label, style: AppTextStyles.heading),
        ),
      ),
    );
  }
}
