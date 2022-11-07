class City {
  int id;
  String name;
  String image;

  City({
    required this.id,
    required this.name,
    required this.image,
  });

  @override
  String toString() {
    return "{'id': ${this.id}, 'name': ${this.name}, 'image': ${this.image}}";
    // return super.toString();
  }
}