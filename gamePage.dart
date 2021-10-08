import 'package:flutter/material.dart';
import 'Game.dart';



class GamePage extends StatefulWidget {

  GamePage({Key? key,
    this.game,
  }) : super(key: key);
  var game;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  TextEditingController playerNameController = new TextEditingController();
  TextEditingController scoreChangeController = new TextEditingController();
  int playerCount = 0;
  Color validateColor = Colors.white;

  void incrementPlayerCount(){
    setState(() {
      playerCount++;
    });
  }


  @override
  Widget build(BuildContext context) {
    String gameName = widget.game.gameName;
    int numPlayers = widget.game.numPlayers;

    return Scaffold(
      appBar: AppBar(
        title: Text(gameName),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(

        child: Column(
          children: <Widget>[

            Row(
              children: [
                ElevatedButton(
                  onPressed: (){
                    widget.game.addPlayer();
                    incrementPlayerCount();
                  },

                  child: Text("Add Player"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                  )
                ),
                ElevatedButton(

                    child: Text("Remove Player"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,

                    ),
                    onPressed: () {
                      deletePlayer();
                    }
                ),
                ElevatedButton(

                    child: Text("Clear Scores"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,

                    ),
                    onPressed: () {
                      clearScores();
                    }
                )
              ],
            ),

            Expanded(
              child: Container(
                child: ListView.builder(
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: widget.game.players.length,
                itemBuilder: (BuildContext context, int i) {
                  return Card(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            editPlayerName(i);
                          },
                          child: Text(widget.game.players[i].getName()),
                        ),
                        ElevatedButton(
                            child: Icon(
                                Icons.add
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green.shade600,

                            ),
                            onPressed: () {
                              changeScore(i);
                            }
                        ),

                        Text(widget.game.players[i].getScore().toString()),

                        Expanded(
                          child: Container(
                            width: 100,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: widget.game.players[i].scoreHistory.length,
                              itemBuilder: (BuildContext context, int j) {
                                if (widget.game.players[i].scoreHistory[j]
                                    .contains("+")) {
                                  return Text(
                                    widget.game.players[i].scoreHistory[j],
                                    style: TextStyle(
                                      fontSize: 10,
                                      backgroundColor: Colors.green,
                                    )
                                  );
                                }
                                else {
                                  return Text(
                                    widget.game.players[i].scoreHistory[j],
                                    style: TextStyle(
                                      fontSize: 10,
                                      backgroundColor: Colors.red,
                                    )
                                  );
                                }
                              }
                            )
                          )
                        ),

                        ElevatedButton(
                            child: Icon(
                              Icons.undo,
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.grey,
                            ),
                            onPressed: () {
                              undo(i);
                            }
                        )


                      ]
                    )
                  );


                })
              )

            )
          ],
        ),
      )
    );
  }

  editPlayerName(int i){
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: TextField(
        autofocus: true,
        controller: playerNameController,
        style: TextStyle(
          fontSize: 40
        ),
        onSubmitted: (String newName) {
          setState(() {
            widget.game.players[i].changeName(newName);
            playerNameController.clear();
            Navigator.pop(context);
          });
        }
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  changeScore(int i) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: TextField(
        autofocus: true,
        controller: scoreChangeController,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 40
        ),
        decoration: InputDecoration(
          fillColor: validateColor,
          filled: true,
        ),
        onSubmitted: (String value) {
          setState(() {
          //   if(!isNumeric(value)){
          //     validateColor = Colors.red.shade200;
          //   }
          //   else {
          //     validateColor = Colors.white;
          //   }
          // });
          // setState(() {
            int scoreChange = int.parse(value);
            widget.game.players[i].changeScore(scoreChange);
            widget.game.players[i].addScoreHistory(scoreChange);
            scoreChangeController.clear();
            Navigator.pop(context);
          });
        }
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  deletePlayer(){
    int playerIndex = 0;
    Widget delete = ElevatedButton(
      child: Text("Delete Player"),
      onPressed: () {
        setState(() {
          widget.game.players.removeAt(playerIndex);
          Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("Edit Player Name"),
      content: Container(
        height: 300.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.game.players.length,
          itemBuilder: (BuildContext context, int index) {
            return TextButton(
              child: Text(
                widget.game.players[index].getName(),
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                )
              ),
              onPressed: () {
                playerIndex = index;
              },
            );
          },
        ),
      ),
      actions: [
        delete,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  clearScores(){

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("Edit Player Name"),
      content: Column(
        children: [
          Text("Are you sure you want to clear all the scores?"),

          ElevatedButton(
            child: Text(
              "Clear Scores",

            ),
            onPressed: (){
              setState(() {
                widget.game.clearScores();
                Navigator.pop(context);
              });
            }
          )
        ]

      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  undo(int i){
    if(widget.game.players[i].scoreHistory.length>0) {
      setState(() {
        String lastChange = widget.game.players[i].scoreHistory[widget.game
            .players[i].scoreHistory.length - 1];
        List tempLastChange = lastChange.split(" ");
        int lastChangeNum = int.parse(tempLastChange[1]);
        String sign = tempLastChange[0];
        if (sign == "+") {
          widget.game.players[i].undoLastScore(-lastChangeNum); //changeScore(-lastChangeNum);
        }
        if (sign == "-") {
          widget.game.players[i].undoLastScore(lastChangeNum); //changeScore(lastChangeNum);
        }
        //widget.game.players[i].scoreHistory.removeLast();
      });
    }
  }



  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }


}
