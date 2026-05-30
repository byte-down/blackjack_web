import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controllers/game_controller.dart';

import '../widgets/card_widget.dart';

import '../widgets/animated_playing_card.dart';

import '../widgets/dealer_animation.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  final ScrollController playerScrollController = ScrollController();

  int previousHandIndex = -1;

  ButtonStyle tableButtonStyle({
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? Colors.black,
      foregroundColor: foregroundColor ?? Colors.amber,
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildCards(List cards) {
    final width = 70 + ((cards.length - 1) * 28);

    return Center(
      child: SizedBox(
        width: width.toDouble(),
        height: 110,
        child: Stack(
          children: List.generate(
            cards.length,
            (index) {
              final card = cards[index];

              return AnimatedPlayingCard(
                left: index * 28,
                top: index.isEven ? 0 : 6,
                rotation: (index - cards.length / 2) * 2,
                child: SizedBox(
                  width: 70,
                  child: CardWidget(
                    asset: 'assets/cards/${card.imageFileName}',
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildDealerCards(
    GameController controller,
  ) {
    final cards = controller.dealerHand.cards;

    final width = 70 + ((cards.length - 1) * 28);

    return Center(
      child: SizedBox(
        width: width.toDouble(),
        height: 110,
        child: Stack(
          children: List.generate(
            cards.length,
            (index) {
              final card = cards[index];

              final hidden = index == 1 && !controller.dealerHoleCardRevealed;

              return AnimatedPlayingCard(
                left: index * 28,
                top: index.isEven ? 0 : 6,
                rotation: (index - cards.length / 2) * 2,
                child: SizedBox(
                  width: 70,
                  child: CardWidget(
                    hidden: hidden,
                    asset: 'assets/cards/${card.imageFileName}',
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    if (controller.currentHandIndex != previousHandIndex) {
      previousHandIndex = controller.currentHandIndex;
      scrollToActiveHand(controller);
    }
    final screenWidth = MediaQuery.of(context).size.width;

    final totalHandWidth = controller.playerHands.length * 180.0;

    final containerWidth =
        totalHandWidth < screenWidth ? screenWidth : totalHandWidth;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // FELT BACKGROUND

          Positioned.fill(
            child: Image.asset(
              'assets/table/felt.png',
              fit: BoxFit.cover,
            ),
          ),

          // DARK OVERLAY

          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.05),
            ),
          ),

          // TABLE CONTENT

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DealerAnimation(
                    state: controller.dealerAnimationState,
                  ),
                  // CustomPaint(
                  //   size: Size(
                  //     MediaQuery.of(context).size.width,
                  //     0,
                  //   ),
                  //   painter: TableArcPainter(),
                  // ),
                  // DEALER
                  Column(
                    children: [
                      Text(
                        controller.dealerDisplayValue,
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      buildDealerCards(controller),
                    ],
                  ),

                  // STATUS

                  Text(
                    controller.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // PLAYER HANDS
                  SizedBox(
                    height: 180,
                    child: controller.playerHands.length == 1

                        // SINGLE HAND (PERFECTLY CENTERED)

                        ? Center(
                            child: AnimatedContainer(
                              duration: const Duration(
                                milliseconds: 300,
                              ),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: controller.playerTurn
                                      ? Colors.amber
                                      : Colors.transparent,
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    controller.currentHand.displayValue,
                                    style: const TextStyle(
                                      color: Colors.amber,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  buildCards(
                                    controller.currentHand.cards,
                                  ),
                                ],
                              ),
                            ),
                          )

                        // MULTIPLE HANDS (SCROLLABLE)

                        : SingleChildScrollView(
                            controller: playerScrollController,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: SizedBox(
                              width: containerWidth,
                              child: Stack(
                                children: List.generate(
                                  controller.playerHands.length,
                                  (handIndex) {
                                    final hand =
                                        controller.playerHands[handIndex];

                                    return AnimatedPositioned(
                                      duration: const Duration(
                                        milliseconds: 500,
                                      ),
                                      curve: Curves.easeOutCubic,
                                      left: totalHandWidth < screenWidth
                                          ? ((screenWidth - totalHandWidth) /
                                                  2) +
                                              (handIndex * 180)
                                          : handIndex * 180,
                                      top: 0,
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: controller.playerTurn &&
                                                    handIndex ==
                                                        controller
                                                            .currentHandIndex
                                                ? Colors.amber
                                                : Colors.transparent,
                                            width: 4,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              hand.displayValue,
                                              style: const TextStyle(
                                                color: Colors.amber,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            buildCards(
                                              hand.cards,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                  ),

                  // INFO BAR

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bankroll: \$${controller.bankroll.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        // Text(
                        //   'Hands: ${controller.handsPlayed}',
                        //   style: const TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 18,
                        //   ),
                        // ),
                        Text(
                          'Wager: \$${controller.totalWager.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // CONTEXTUAL CONTROLS

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: controller.isPlaying

                        // =========================
                        // IN HAND CONTROLS
                        // =========================

                        ? Column(
                            key: const ValueKey('playing_controls'),
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: tableButtonStyle(),
                                        onPressed: controller.playerTurn &&
                                                controller
                                                    .playerHands.isNotEmpty
                                            ? () {
                                                controller.hit();
                                              }
                                            : null,
                                        child: const Text('Hit'),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: tableButtonStyle(),
                                        onPressed: controller.playerTurn &&
                                                controller
                                                    .playerHands.isNotEmpty
                                            ? () {
                                                controller.stand();
                                              }
                                            : null,
                                        child: const Text('Stand'),
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 12),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        style: tableButtonStyle(),
                                        onPressed: controller.playerTurn &&
                                                controller
                                                    .playerHands.isNotEmpty &&
                                                controller.currentHand.cards
                                                        .length ==
                                                    2
                                            ? () {
                                                controller.doubleDown();
                                              }
                                            : null,
                                        child: const Text('Double'),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: ElevatedButton(
                                        style: tableButtonStyle(),
                                        onPressed: controller.playerTurn &&
                                                controller
                                                    .playerHands.isNotEmpty &&
                                                controller.currentHand.canSplit
                                            ? () {
                                                controller.split();
                                              }
                                            : null,
                                        child: const Text('Split'),
                                      ),
                                    ),
                                  ],
                                ),
                              
                            ],
                          )

                        // =========================
                        // PRE HAND BETTING
                        // =========================

                        : Column(
                            key: const ValueKey('betting_controls'),
                            children: [
                              SizedBox(
                                width: 140,
                                child: TextField(
                                  controller: controller.betController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.black26,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    prefixText: '\$',
                                    prefixStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onChanged: controller.updateBet,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: controller.halveBet,
                                        style: tableButtonStyle(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text('0.5x'),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          controller.startHand();
                                        },
                                        style: tableButtonStyle(
                                          backgroundColor: Colors.green[700],
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text('Deal'),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: controller.doubleBet,
                                        style: tableButtonStyle(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text('2x'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void scrollToActiveHand(
    GameController controller,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!playerScrollController.hasClients) {
        return;
      }

      final handCount = controller.playerHands.length;

      if (handCount <= 0) {
        return;
      }

      final maxIndex = handCount - 1;

      final safeIndex = controller.currentHandIndex < 0
          ? 0
          : controller.currentHandIndex > maxIndex
              ? maxIndex
              : controller.currentHandIndex;

      final screenWidth = MediaQuery.of(context).size.width;

      final targetOffset = (safeIndex * 180.0) - (screenWidth / 2) + 90;

      final maxScroll = playerScrollController.position.maxScrollExtent;

      playerScrollController.animateTo(
        targetOffset.clamp(
          0,
          maxScroll,
        ),
        duration: const Duration(
          milliseconds: 400,
        ),
        curve: Curves.easeOutCubic,
      );
    });
  }
}

class TableArcPainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = Colors.amber.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final rect = Rect.fromLTWH(
      40,
      -140,
      size.width - 80,
      280,
    );

    canvas.drawArc(
      rect,
      0.2,
      2.75,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(
    CustomPainter oldDelegate,
  ) {
    return false;
  }
}
