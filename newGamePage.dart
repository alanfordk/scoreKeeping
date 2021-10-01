


import 'package:flutter/material.dart';
import 'dart:convert';
import 'Game.dart';
import 'gamePage.dart';


class NewGamePage extends StatefulWidget {
  @override
  NewGamePageState createState() => NewGamePageState();
}


class NewGamePageState extends State<NewGamePage> {

  TextEditingController gameNameController = new TextEditingController();
  TextEditingController gamePlayersController = new TextEditingController();

  String numPlayersHint = "Number of Players";
  Color numPlayersColor = Colors.white;




  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('New Game'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
          padding: EdgeInsets.all(10),

          child: ListView(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top:5),
                    child: Text(
                      'Enter the Game Name',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: gameNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Game Name',
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top:5),
                    child: Text(
                      'Enter the number of players',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    // color: numPlayersColor,
                    child: TextField(
                      controller: gamePlayersController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: numPlayersColor,
                        filled: true,
                        labelText: numPlayersHint,
                      ),
                      onSubmitted: (input) {
                        if(input.contains(".")){
                          setState(() {
                            numPlayersHint = "Error";
                            numPlayersColor = Colors.red.shade300;
                          });
                        }
                        else if(!isNumeric(input)) {
                          setState(() {
                            numPlayersHint = "Error";
                            numPlayersColor = Colors.red.shade200;
                          });
                        }
                        else {
                          setState(() {
                            numPlayersHint = "Number of Players";
                            numPlayersColor = Colors.white;
                          });
                        }
                      }
                    ),
                ),

                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      // textColor: Colors.white,
                      // color: Colors.red,
                      child: Text('Create Game'),
                      onPressed: () {
                        String gameName = gameNameController.text;
                        String gamePlayersText = gamePlayersController.text;
                        int gamePlayers = int.parse(gamePlayersText);
                        if (gamePlayersText.contains('.')) {
                          numPlayersColor = Colors.red.shade400;
                        }
                        else if (!isNumeric(gamePlayersText)) {
                          numPlayersColor = Colors.red.shade400;
                        }
                        else {
                          Game game = new Game(gameName, gamePlayers);

                          for(var i=1; i<=gamePlayers; i++){
                            game.addPlayer();
                          }
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => GamePage(game: game,)),
                          );
                        }
                      },
                    )
                ),
              ]
          )
      )
  );



  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}



