import 'package:flutter/material.dart';
import 'Game.dart';
import 'player.dart';
import 'gamePage.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scorer/Boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(GameAdapter());
  // Hive.registerAdapter(PlayerAdapter());
  await Hive.openBox<Game>('games');
  // await Hive.openBox<Player>('players');

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
  TextEditingController gameNameController = new TextEditingController();
  TextEditingController gamePlayersController = new TextEditingController();

  String numPlayersHint = "Number of Players";
  Color numPlayersColor = Colors.white;

  // var games = [];

  void getData(){
    //Put code to get data in here
  }

  @override
  void initState(){
    super.initState();
    print('initstate ran');
  }


  @override
  Widget build(BuildContext context) {
    print('build ran');
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
              child: ValueListenableBuilder<Box<Game>>(
                valueListenable: Boxes.getGames().listenable(),
                builder: (context, box, _) {
                  final games = box.values.toList().cast<Game>();
                  return gamesTemplate(games);
                }
              )
            )
          ],
        ),
      ),
    );
  }

  Widget gamesTemplate(List<Game> games){
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: games.length,
        itemBuilder: (BuildContext context, int j) {
          return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    editGameName(games[j]);
                    // final box = Boxes.getGames();
                    // games[j].save();
                  },
                  child: Text(games[j].getName()),
                ),
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
                      games[j].delete();
                    });
                  },
                  child: Text("Delete Game"),
                )
              ]
          );
        }
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
          // games.add(game);

          final box = Boxes.getGames();
          box.add(game);
          // box.put('mykey', game);

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

  editGameName(Game game){
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: TextField(
          autofocus: true,
          controller: gameNameController,
          style: TextStyle(
              fontSize: 40
          ),
          onSubmitted: (String newName) {
            setState(() {
              game.changeGameName(newName);
              gameNameController.clear();
              game.save();
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



  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  void dispose(){
    // Hive.close();
    Hive.box('games').close();
    super.dispose();
  }
}

