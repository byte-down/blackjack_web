import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'controllers/game_controller.dart';

import 'ui/table_screen.dart';

void main() {

  runApp(

    ChangeNotifierProvider(

      create: (_) => GameController(),

      child: const BlackjackApp(),
    ),
  );
}

class BlackjackApp extends StatelessWidget {

  const BlackjackApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(

      debugShowCheckedModeBanner: false,

      home: TableScreen(),
    );
  }
}