import 'package:flutter/material.dart';

import 'dart:math';

class CardWidget extends StatelessWidget {

  final String asset;

  final bool hidden;

  const CardWidget({
    super.key,
    required this.asset,
    this.hidden = false,
  });

  @override
  Widget build(BuildContext context) {

    return AnimatedSwitcher(

      duration:
          const Duration(milliseconds: 600),

      transitionBuilder:
          (child, animation) {

        final rotate = Tween(
          begin: 3.14,
          end: 0.0,
        ).animate(animation);

        return AnimatedBuilder(

          animation: rotate,

          child: child,

          builder: (context, child) {

            final isUnder =
                (ValueKey(hidden) !=
                    child!.key);

            double tilt =
                (animation.value - 0.5).abs()
                    - 0.5;

            tilt *= isUnder ? -0.003 : 0.003;

            final value =
                isUnder
                    ? min(
                        rotate.value,
                        1.57,
                      )
                    : rotate.value;

            return Transform(

              transform:
                  Matrix4.rotationY(value)
                    ..setEntry(3, 0, tilt),

              alignment: Alignment.center,

              child: child,
            );
          },
        );
      },

      child: hidden

          ? Image.asset(
              'assets/cards/back.png',
              key: const ValueKey(true),
              width: 90,
            )

          : Image.asset(
              asset,
              key: const ValueKey(false),
              width: 90,
            ),
    );
  }
}