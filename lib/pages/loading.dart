import 'package:charades_eu/services/DatabaseHandler.dart';
import 'package:charades_eu/widgets/GameMode.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Loading extends StatefulWidget {
  const Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  DatabaseHandler handler;

  void setup() async {
    List<GameMode> gameModes = await getGameModes();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: gameModes);
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

  Future<List<GameMode>> getGameModes() async {
    List<GameMode> gameModes = [];
    this.handler = DatabaseHandler();
    this.handler.initDatabase().whenComplete(() async {
      gameModes = await this.handler.retrieveGameModes();
    });
    return Future.delayed(Duration(seconds: 1), () => gameModes);
  }
}
