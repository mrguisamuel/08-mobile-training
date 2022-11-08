import "package:flutter/material.dart";

class Session {
  static int totalWords = 0;
  static int correctWords = 0;
  static int buttonSelectCounter = -1;
  static double totalReactTime = 0;
  static bool isDefaultGame = true;
  static int points = 0;

  // Variables for config the game
  static int seconds = 30;
  static int secondsPerWord = 3;
  static int numberWords = 10;
  static bool numberOptionSelected = false;

  static Map<String, Color> allColors = {
    'Amarelo' : Color(0xFFFFEB3B),
    'Azul' : Color(0xFF12197F3),
    'Laranja' : Color(0xFFFF9800),
    'Vermelho' : Color(0xFFF44336),
    'Verde' : Color(0xFF4CAF50),
    'Roxo' : Color(0xFF673AB7),
    'Preto' : Color(0xFF000000)
  };

  static void resetGame([bool isLight = true]) {
    totalWords = 0;
    correctWords = 0;
    buttonSelectCounter = -1;
    totalReactTime = 0;
    points = 0;
    if(isLight) {
      allColors = {
        'Amarelo' : Color(0xFFFFEB3B),
        'Azul' : Color(0xFF12197F3),
        'Laranja' : Color(0xFFFF9800),
        'Vermelho' : Color(0xFFF44336),
        'Verde' : Color(0xFF4CAF50),
        'Roxo' : Color(0xFF673AB7),
        'Preto' : Color(0xFF000000)
      };
    } else {
      allColors = {
        'Amarelo' : Color(0xFFFFEB3B),
        'Azul' : Color(0xFF12197F3),
        'Laranja' : Color(0xFFFF9800),
        'Vermelho' : Color(0xFFF44336),
        'Verde' : Color(0xFF4CAF50),
        'Roxo' : Color(0xFF673AB7),
        'Branco' : Color(0xFFFFFFFF)
      };
    }
    seconds = 30;
    secondsPerWord = 3;
    numberWords = 10;
    numberOptionSelected = false;
    isDefaultGame = true;
  }

  static void addPoints(int numberPoints) {
    points += numberPoints;
  }

  static void removePoints(int numberPoints) {
    points -= numberPoints;
    if(points <= 0) points = 0;
  }
}