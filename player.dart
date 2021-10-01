

class Player {
  String name;
  int playerScore;
  List scoreHistory;

  Player(this.name, this.playerScore, this.scoreHistory);

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



}