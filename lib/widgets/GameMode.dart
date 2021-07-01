class GameMode {
  final int id;
  final String title;
  final String category;
  final String image;

  GameMode({this.id, this.title, this.category, this.image});

  GameMode.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        title = map["title"],
        category = map["category"],
        image = map["image"];

  Map<String, Object> toMap() {
    return {"id": id, "title": title, "category": category, "image": image};
  }
}
