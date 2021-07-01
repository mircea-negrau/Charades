import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:io';
import 'package:sensors/sensors.dart';

class Game extends StatefulWidget {
  const Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> with TickerProviderStateMixin {
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  AnimationController controller;
  final random = new Random();
  String word;
  bool next = true;
  bool changed = false;
  int correct = 0;
  int wrong = 0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 150),
    )..addListener(() {
        setState(() {});
        checkTime();
      });
    controller.animateTo(1);
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);

    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
      });
    }));
  }

  void checkTime() {
    if (controller.isCompleted) {
      next = true;
      controller.reset();
      controller.animateTo(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final words = ModalRoute.of(context).settings.arguments as List<String>;

    final List<String> gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();

    if (next) {
      if (changed) {
        changed = false;
        sleep(Duration(seconds: 1));
      }
      words.remove(word);
      if (words.isNotEmpty) {
        word = words[random.nextInt(words.length)];
        next = false;
      } else {
        word = "Game over!";
        controller.stop();
        return Scaffold(
          body: Container(
            color: Colors.lightBlueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 5.0,
                        width: 500.0,
                      ),
                    ),
                    SizedBox(
                      height: 125.0,
                    ),
                    Row(
                      children: [
                        Text(
                          word,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 75.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    TextButton(
                      child: Text(
                        "Back to main menu",
                        style: TextStyle(fontSize: 25.0),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text(
                        "$wrong wrong | $correct correct",
                        style: TextStyle(fontSize: 35.0),
                      ),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    } else {
      if (_gyroscopeValues[1] <= -2.5) {
        next = true;
        changed = true;
        correct += 1;
        print("CORRECT");
      } else if (_gyroscopeValues[1] >= 2.5) {
        next = true;
        changed = true;
        wrong += 1;
        print("INCORRECT");
      }
    }
    return Scaffold(
      body: Container(
        color: Colors.lightBlueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 5.0,
                    width: 500.0,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      value: controller.value,
                    ),
                  ),
                ),
                SizedBox(
                  height: 125.0,
                ),
                Row(
                  children: [
                    Text(
                      word,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 75.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Gyroscope: $gyroscope'),
                    ],
                  ),
                  padding: const EdgeInsets.all(16.0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    controller.dispose();
    super.dispose();

    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
}
