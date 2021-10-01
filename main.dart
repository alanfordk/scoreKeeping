import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'myGames.dart';
import 'newGamePage.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Menu')
        // title: Text(widget.title),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new ListTile(
              title: new Text( 'Settings Page'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => SettingsPage()),
                );
              },
            ),
            new ListTile(
              title: new Text('My Games'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => MyGamesPage()),
                );
              }
            )
          ]
        )
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
          ],
        ),
      ),
    );
  }

  void newGameSelected(){
    print('New Game Selected');
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NewGamePage()),
    );
  }
}
