import 'dart:async';

import 'package:flutter/material.dart';

import '../models/dealer_animation_state.dart';

class DealerAnimation extends StatefulWidget {
  final DealerAnimationState state;

  const DealerAnimation({
    super.key,
    required this.state,
  });

  @override
  State<DealerAnimation> createState() =>
      _DealerAnimationState();
}

class _DealerAnimationState
    extends State<DealerAnimation> {
  late Timer timer;

  int frameIndex = 0;

  List<String> currentFrames = [];

  @override
  void initState() {
    super.initState();

    loadFrames();

    timer = Timer.periodic(
      const Duration(milliseconds: 240),
      (_) {
        if (!mounted) return;

        setState(() {
          frameIndex++;

          if (frameIndex >= currentFrames.length) {
            frameIndex = 0;
          }
        });
      },
    );
  }

  @override
  void didUpdateWidget(
    covariant DealerAnimation oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      frameIndex = 0;
      loadFrames();
    }
  }

  void loadFrames() {
    switch (widget.state) {
      case DealerAnimationState.idle:
        currentFrames = [
          'assets/dealer/idle/idle_01.png',
          'assets/dealer/idle/idle_02.png',
          'assets/dealer/idle/idle_03.png',
          'assets/dealer/idle/idle_04.png',
        ];
        break;

      case DealerAnimationState.pickup:
        currentFrames = [
          'assets/dealer/pickup/pick_01.png',
          'assets/dealer/pickup/pick_02.png',
          'assets/dealer/pickup/pick_03.png',
          'assets/dealer/pickup/pick_04.png',
        ];
        break;

      case DealerAnimationState.dealPlayer:
        currentFrames = [
          'assets/dealer/deal_player/deal_01.png',
          'assets/dealer/deal_player/deal_02.png',
          'assets/dealer/deal_player/deal_03.png',
          'assets/dealer/deal_player/deal_04.png',
          'assets/dealer/deal_player/deal_05.png',
          'assets/dealer/deal_player/deal_06.png',
        ];
        break;

      default:
        currentFrames = [
          'assets/dealer/idle/idle_01.png',
        ];
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Image.asset(
        currentFrames[frameIndex],
        fit: BoxFit.contain,
      ),
    );
  }
}