import 'package:flutter/cupertino.dart';

class Game {
  String gameName;
  int numPlayers;

  Game(this.gameName, this.numPlayers);

  changeGameName(String newName){
    this.gameName = newName;
  }

}



