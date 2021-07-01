import 'package:charades_eu/widgets/appBar.dart';
import 'package:charades_eu/widgets/GameMode.dart';
import 'package:charades_eu/widgets/categoryBar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final gameModes =
        ModalRoute.of(context).settings.arguments as List<GameMode>;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Side menu',
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
      appBar: createAppBar(context),
      body: createBody(context, gameModes),
      backgroundColor: Colors.lightBlueAccent,
    );
  }
}

SafeArea createBody(context, gameModes) {
  return SafeArea(
    child: createCategoryBars(context, gameModes),
  );
}

ListView createCategoryBars(context, gameModes) {
  List<Padding> categoryBars = [];
  for (GameMode gameMode in gameModes) {
    categoryBars.add(createCategoryBar(context, gameMode));
  }
  return ListView(
    children: [
      SizedBox(
        height: 10.0,
      ),
      ...categoryBars,
    ],
  );
}
