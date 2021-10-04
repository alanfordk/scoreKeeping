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

  void incrementPlayerCount(){
    setState(() {
      playerCount++;
      print(playerCount);
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
                                return Card(
                                  child: Text(
                                    widget.game.players[i].scoreHistory[j],
                                    style: TextStyle(
                                      fontSize: 30
                                    )
                                  )

                                );
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
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {


          String newName = playerNameController.text;
          widget.game.players[i].changeName(newName);
          Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Edit Player Name"),
      content: TextField(
        controller: playerNameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        okButton,
      ],
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
    Widget submit = ElevatedButton(
      child: Text("Change Score"),
      onPressed: () {
        setState(() {
          int scoreChange = int.parse(scoreChangeController.text);
          widget.game.players[i].changeScore(scoreChange);
          widget.game.players[i].addScoreHistory(scoreChange);
          Navigator.pop(context);
        });
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("Edit Player Name"),
      content: TextField(
        controller: scoreChangeController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        submit,
      ],
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
              child: Text(widget.game.players[index].getName()),
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

  undo(int i){
    if(widget.game.players[i].scoreHistory.length>0) {
      setState(() {
        String lastChange = widget.game.players[i].scoreHistory[widget.game
            .players[i].scoreHistory.length - 1];
        List tempLastChange = lastChange.split(" ");
        int lastChangeNum = int.parse(tempLastChange[1]);
        String sign = tempLastChange[0];
        if (sign == "+") {
          widget.game.players[i].changeScore(-lastChangeNum);
        }
        if (sign == "-") {
          widget.game.players[i].changeScore(lastChangeNum);
        }
        widget.game.players[i].scoreHistory.removeLast();
      });
    }
  }


}


// class GamePage extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child:Game(gameName: "testGAmeNAme")
//     );
//
//   }
// }