import 'package:flutter/cupertino.dart';
import 'player.dart';
import 'package:hive/hive.dart';
import 'package:scorer/Boxes.dart';


part 'Game.g.dart';

@HiveType(typeId:0)
class Game extends HiveObject{

  @HiveField(0)
  String gameName;

  @HiveField(1)
  int numPlayers;

  Game(this.gameName, this.numPlayers);

  List players = [];

  addPlayer(){
    players.add(new Player("newPlayer", 0, []));
    // final box = Boxes.getPlayers();
    // box.add(player);
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

  clearScores(){
    for(int i=0; i<this.players.length; i++){
      this.players[i].clearScore();
    }
  }



}



