import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedPlayingCard extends StatelessWidget {

  final Widget child;

  final double left;

  final double top;

  final double rotation;

  final Duration duration;

  const AnimatedPlayingCard({
    super.key,
    required this.child,
    required this.left,
    required this.top,
    this.rotation = 0,
    this.duration =
        const Duration(milliseconds: 400),
  });

  @override
  Widget build(BuildContext context) {

    return AnimatedPositioned(

      duration: duration,

      curve: Curves.easeOutCubic,

      left: left,
      top: top,

      child: TweenAnimationBuilder<double>(

        tween:
            Tween(begin: 0, end: rotation),

        duration: duration,

        builder: (
          context,
          value,
          child,
        ) {

          return Transform.rotate(

            angle: value * pi / 180,

            child: child,
          );
        },

        child: child,
      ),
    );
  }
}