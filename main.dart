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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 100,
        height: 100,
        child: FloatingActionButton(
          onPressed: newGameSelected,
          backgroundColor: Colors.blueGrey,
          child: Text('New Game'),
        )

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void newGameSelected(){
    print('New Game Selected');
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NewGamePage()),
    );
  }
}
