import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';




class Player extends HiveObject{


  String name;

  int playerScore;


  List scoreHistory;

  Player(this.name, this.playerScore, this.scoreHistory);


  Map<String, dynamic> toJson() => {
    'name': name,
    'playerScore': playerScore,
  };


  changeName(String newName){
    this.name = newName;
  }
  getName(){
    return this.name;
  }

  getScore(){
    return this.playerScore;
  }

  changeScore(int change) {
    this.playerScore = this.playerScore + change;
  }

  addScoreHistory(int change){
    if (change<0){
      scoreHistory.add("- " + (change.abs()).toString());
    }
    else if (change > 0){
      scoreHistory.add("+ " + change.toString());
    }
    else {
      scoreHistory.add("0");
    }
  }

  undoLastScore(int i){
    changeScore(i);
    this.scoreHistory.removeLast();
  }

  clearScore(){
    this.playerScore = 0;
    this.scoreHistory.clear();
  }





}