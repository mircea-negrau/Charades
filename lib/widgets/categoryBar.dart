import 'package:flutter/material.dart';

import 'GameMode.dart';

Padding createCategoryBar(context, gameMode) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Card(
      clipBehavior: Clip.antiAlias,
      child: createContainer(context, gameMode),
    ),
  );
}

Container createContainer(context, gameMode) {
  return Container(
    color: Colors.blue[400],
    child: OutlinedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/loadingGame', arguments: gameMode);
      },
      child: createUpperPart(context, gameMode),
    ),
  );
}

ListTile createUpperPart(context, GameMode gameMode) {
  return ListTile(
    leading: createImage(context, gameMode),
    title: Text(
      gameMode.title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: Colors.white,
      ),
    ),
    subtitle: Text(
      gameMode.category,
      style: TextStyle(
        color: Colors.black.withOpacity(0.6),
      ),
    ),
  );
}

AspectRatio createImage(context, GameMode gameMode) {
  return AspectRatio(
    aspectRatio: 1.5,
    child: Image.asset(
      gameMode.image,
    ),
  );
}
