import 'package:charades_eu/widgets/GameMode.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseHandler {
  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    return openDatabase(
      path.join(databasePath, 'TESTTESTT124129041289u.db'),
      onCreate: (database, version) async {
        print("CREATING");
        await database.execute(
          "CREATE TABLE gameModes(id INTEGER PRIMARY KEY, title TEXT,category TEXT, image TEXT)",
        );
        await database.execute(
            'INSERT INTO gameModes(id, title, category, image) VALUES (1, "Geography of Europe", "Geography", "assets/geography.png")');
        await database.execute(
            'INSERT INTO gameModes(id, title, category, image) VALUES (2, "Geography of Asia", "Geography", "assets/geography.png")');
        await database.execute(
            'INSERT INTO gameModes(id, title, category, image) VALUES (3, "History of America", "History", "assets/geography.png")');
        await database.execute(
            'INSERT INTO gameModes(id, title, category, image) VALUES (4, "Mathematics", "Science", "assets/geography.png")');
        await database.execute(
            'INSERT INTO gameModes(id, title, category, image) VALUES (5, "Programming", "Science", "assets/geography.png")');
        await database.execute(
            'INSERT INTO gameModes(id, title, category, image) VALUES (6, "Historical Figures", "History", "assets/geography.png")');
        await database.execute(
            'INSERT INTO gameModes(id, title, category, image) VALUES (7, "Presidents", "History", "assets/geography.png")');
        await database.execute(
            'INSERT INTO gameModes(id, title, category, image) VALUES (8, "Actors", "Theatre", "assets/geography.png")');
        await database.execute(
            'INSERT INTO gameModes(id, title, category, image) VALUES (9, "Movies", "Theatre", "assets/geography.png")');
      },
      version: 1,
    );
  }

  Future<int> insertGameMode(List<GameMode> gameModes) async {
    int result = 0;
    final Database database = await initDatabase();
    for (var gameMode in gameModes) {
      result = await database.insert('gameModes', gameMode.toMap());
    }
    return result;
  }

  Future<List<GameMode>> retrieveGameModes() async {
    final Database database = await initDatabase();
    final List<Map<String, Object>> queryResult =
        await database.query('gameModes');
    return queryResult.map((gameMode) => GameMode.fromMap(gameMode)).toList();
  }

  Future<void> deleteGameMode(int id) async {
    final database = await initDatabase();
    await database.delete(
      'gameModes',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
