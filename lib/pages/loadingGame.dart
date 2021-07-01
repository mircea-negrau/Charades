import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoadingGame extends StatefulWidget {
  const LoadingGame({Key key}) : super(key: key);

  @override
  _LoadingGameState createState() => _LoadingGameState();
}

class _LoadingGameState extends State<LoadingGame> {
  void setup() async {
    List<String> words = await createWords();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/game', arguments: words);
    });
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "Loading",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    JumpingDotsProgressIndicator(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<List<String>> createWords() {
    List<String> categories = [
      "Ungaria",
      "Rusia",
      "Islanda",
      "Malta",
      "Japonia",
      "Correa de Nord",
    ];
    return Future.delayed(Duration(seconds: 1), () => categories);
  }
}