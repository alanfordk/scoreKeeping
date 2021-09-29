

class Player {
  String name;
  int playerScore;
  List scoreHistory;

  Player(this.name, this.playerScore, this.scoreHistory);

  changeName(String newName){
    this.name = newName;
  }

  changeScore(int change){
    this.playerScore = this.playerScore + change;
    if (change<0){
      scoreHistory.add("- " + change.toString());
    }
    else if (change > 0){
      scoreHistory.add("+ " + change.toString());
    }
    else {
      scoreHistory.add("0");
    }


  }


}