import 'dart:math';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class Bubble {
  Offset position;
  double radius;
  double targetRadius;
  Color color;
}

class BubbleBehaviour extends Behaviour {
  static Random random = Random();
  List<Bubble> _bubbles;
  static const int numBubbles = 20;
  static const double minTargetRadius = 10.0;
  static const double maxTargetRadius = 15.0;
  static const double growthRate = 10.0;

  @override
  void init() {
    _bubbles = List<Bubble>.generate(numBubbles, (_) {
      Bubble bubble = Bubble();
      _initBubble(bubble);
      return bubble;
    });
  }

  void _initBubble(Bubble bubble) {
    bubble.position = Offset(
      random.nextDouble() * size.width,
      random.nextDouble() * size.height,
    );
    bubble.radius = 0.0;
    bubble.targetRadius =
        random.nextDouble() * (maxTargetRadius - minTargetRadius) +
            minTargetRadius;
    bubble.color = Colors.white;
  }

  @override
  void initFrom(Behaviour oldBehaviour) {
    if (oldBehaviour is BubbleBehaviour) {
      _bubbles = oldBehaviour._bubbles;
    }
  }

  @override
  bool get isInitialized => _bubbles != null;

  @override
  void paint(PaintingContext context, Offset offset) {
    var canvas = context.canvas;
    Paint paint = Paint()
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;
    for (var bubble in _bubbles) {
      paint.color = bubble.color;
      canvas.drawCircle(bubble.position, bubble.radius, paint);
    }
  }

  @override
  bool tick(double delta, Duration elapsed) {
    if (!isInitialized) return false;
    for (var bubble in _bubbles) {
      bubble.radius += growthRate * delta;

      if (bubble.radius >= bubble.targetRadius) _initBubble(bubble);
    }
    return true;
  }

  @override
  Widget builder(
      BuildContext context, BoxConstraints constraints, Widget child) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (details) => _onTap(context, details.globalPosition),
      child: super.builder(context, constraints, child),
    );
  }

  void _onTap(BuildContext context, Offset globalPosition) {
    RenderBox renderBox = context.findRenderObject();
    var localPosition = renderBox.globalToLocal(globalPosition);
    for (var bubble in _bubbles) {
      if ((bubble.position - localPosition).distanceSquared <
          bubble.radius * bubble.radius * 1.2) {
        _initBubble(bubble);
      }
    }
  }
}
