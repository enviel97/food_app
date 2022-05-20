extension StringX on String {
  String get firstUperCase {
    return this[0].toUpperCase() + substring(1, length);
  }
}
