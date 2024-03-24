// Dart imports:
import 'dart:math';

class RandomDatesGenerator {
  static final int _randomYear = _initRandomYear();
  static final int _randomDecade = _initRandomDecade();

  static int get randomYear => _randomYear;
  static int get randomDecade => _randomDecade;

  static int _initRandomYear() {
    final random = Random();
    final int currentYear = DateTime.now().year;
    return random.nextInt(currentYear - 1970 + 1) + 1970;
  }

  static int _initRandomDecade() {
    final random = Random();
    final List<int> decades = [1970, 1980, 1990, 2000, 2010, 2020];
    return decades[random.nextInt(decades.length)];
  }
}
