import 'package:flutter/material.dart';
import 'Game.dart';
import 'gamePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Score Keeper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'App Bar'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  TextEditingController gameNameController = new TextEditingController();
  TextEditingController gamePlayersController = new TextEditingController();

  String numPlayersHint = "Number of Players";
  Color numPlayersColor = Colors.white;
  var games = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Games')
        // title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                  ),
                  child: Text(
                    "New Game",
                    style: TextStyle(
                      fontSize: 20,
                    )
                  ),
                  onPressed: () {
                    newGameSelected();
                  },
                ),
              ]
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: games.length,
                  itemBuilder: (BuildContext context, int j) {
                    return Row(
                        children: [
                          Text(games[j].getName(),
                              style: TextStyle(
                                  fontSize: 30
                              )),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => GamePage(game: games[j],)),
                              );
                            },
                            child: Text("Go to Game"),

                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                games.removeAt(j);
                              });
                            },
                            child: Text("Delete Game"),
                          )
                        ]
                    );
                  }
              )
            )
          ],
        ),
      ),
    );
  }

  void newGameSelected(){

    Widget create = ElevatedButton(
      child: Text("Create Game"),
      onPressed: () {
        setState(() {
          String gameName = gameNameController.text;
          String gamePlayersText = gamePlayersController.text;
          int gamePlayers = int.parse(gamePlayersText);

          Game game = new Game(gameName, gamePlayers);
          for(var i=1; i<=gamePlayers; i++){
            game.addPlayer();
          }
          games.add(game);
          Navigator.of(context).pop();
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => GamePage(game: game,)),
          );
          // Navigator.pop(context);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("Edit Player Name"),
      content: Column(
        children: [
          Text(
            "What is the name of the Game?",
            style: TextStyle(
              fontSize: 20,
            )
          ),

          TextField(
            controller: gameNameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),

          Text(
              "How many players are there?",
              style: TextStyle(
                fontSize: 20,
              )
          ),

          TextField(
            controller: gamePlayersController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              fillColor: numPlayersColor,
              filled: true,
            ),
            onChanged: (input) {
                if(input.contains(".")){
                  numPlayersColor = Colors.red.shade300;
                  setState(() {
                  });
                }
                else if(!isNumeric(input)){
                  numPlayersColor = Colors.red.shade300;
                }
                else {
                  setState(() {
                    numPlayersHint = "Number of Players";
                    numPlayersColor = Colors.white;
                  });
                }
            },
          ),
        ]
      ),

      actions: [
        create,
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

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}