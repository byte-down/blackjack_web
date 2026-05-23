import 'package:flutter/material.dart';

import 'engine/blackjack_game.dart';
import 'engine/simulator.dart';

import 'models/shoe.dart';

import 'strategies/basic_strategy.dart';

void main() {
  runApp(const BlackjackApp());
}

class BlackjackApp extends StatelessWidget {
  const BlackjackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  String results = '';

  void runSimulation() {

    final shoe = Shoe(decks: 6);

    final game = BlackjackGame(
      shoe: shoe,
      strategy: BasicStrategy(),
      hitSoft17: true,
    );

    final simulator = Simulator(game);

    final data = simulator.run(100000);

    setState(() {
      results = data.toString();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blackjack Bot'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [

              ElevatedButton(
                onPressed: runSimulation,
                child: const Text(
                  'Run 100,000 Hands',
                ),
              ),

              const SizedBox(height: 20),

              Text(results),
            ],
          ),
        ),
      ),
    );
  }
}