import 'package:flutter/cupertino.dart';
import 'player.dart';

class Game {
  String gameName;
  int numPlayers;

  Game(this.gameName, this.numPlayers);

  var players = [];

  addPlayer(){
    players.add(new Player("newPlayer", 0, []));
  }

  changeGameName(String newName){
    this.gameName = newName;
  }

  getName() {
    return this.gameName;
  }

  deletePlayer(int i){
    players.removeAt(i);
  }

}



