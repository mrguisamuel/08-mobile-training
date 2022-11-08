import 'dart:math';

class Utility {
  static double roundDouble(double value, int places) {
    var mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}