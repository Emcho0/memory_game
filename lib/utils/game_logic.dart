import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;

  List<Color> cards = [
    Colors.green,
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.blue,
    Colors.blue,
    Colors.purple,
    Colors.purple,
    Colors.orange,
    Colors.orange,
    Colors.red,
    Colors.red,
    Colors.cyan,
    Colors.cyan,
    Colors.brown,
    Colors.brown,
  ];

  final String hiddenCardpath = "assets/images/hidden.png";

  // Veca lista da zauzme 16 karti
  List<String> cardsList = [
    "assets/images/circle.png",
    "assets/images/heart.png",
    "assets/images/star.png",
    "assets/images/circle.png",
    "assets/images/heart.png",
    "assets/images/triangle.png",
    "assets/images/star.png",
    "assets/images/triangle.png",
    "assets/images/circle.png",
    "assets/images/triangle.png",
    "assets/images/star.png",
    "assets/images/heart.png",
    "assets/images/circle.png",
    "assets/images/heart.png",
    "assets/images/star.png",
    "assets/images/triangle.png",
  ];

  final int cardCount = 16;
  List<Map<int, String>> matchCheck = [];

  // methods
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
