import "package:flutter/material.dart";

class Session {
  static int totalWords = 0;
  static int correctWords = 0;
  static int buttonSelectCounter = -1;
  static double totalReactTime = 0;
  static bool isDefaultGame = true;
  static int points = 0;

  static Map<String, MaterialColor> allColors = {
    'Amarelo' : Colors.yellow,
    'Azul' : Colors.blue,
    'Laranja' : Colors.orange,
    'Vermelho' : Colors.red,
    'Verde' : Colors.green,
    'Roxo' : Colors.purple,
  };

  static void resetGame() {
    totalWords = 0;
    correctWords = 0;
    buttonSelectCounter = -1;
    totalReactTime = 0;
    points = 0;
  }

  static void addPoints(int numberPoints) {
    points += numberPoints;
  }

  static void removePoints(int numberPoints) {
    points -= numberPoints;
    if(points <= 0) points = 0;
  } 
}