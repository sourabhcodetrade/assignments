class User {
  final String name;
  final int flutterExperience;

  User({required this.name, required this.flutterExperience});

  @override
  String toString() {
    return "$name has ${flutterExperience.toString()} years of Experience";
  }
}
