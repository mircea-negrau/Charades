import 'package:charades_eu/pages/game.dart';
import 'package:charades_eu/pages/home.dart';
import 'package:charades_eu/pages/loading.dart';
import 'package:charades_eu/pages/loadingGame.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/home': (context) => Home(),
          '/game': (context) => Game(),
          '/loadingGame': (context) => LoadingGame(),
        },
      ),
    );
