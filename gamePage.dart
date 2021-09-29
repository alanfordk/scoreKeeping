import 'package:flutter/material.dart';
import 'Game.dart';



class GamePage extends StatefulWidget {
  const GamePage({Key? key,
    this.gameName,
    this.numPlayers,
  }) : super(key: key);
  final gameName;
  final numPlayers;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    String gameName = widget.gameName;
    int numPlayers = widget.numPlayers;
    return Scaffold(
      appBar: AppBar(
        title: Text(gameName),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(

        child: Column(
          children: <Widget>[

            Container(
              width: 100,
              height: 100,
              child: FloatingActionButton(
                onPressed: (){

                },
                backgroundColor: Colors.grey,
                child: Text("Add Player"),
              )
            ),
            Row(
              children: <Widget>[
                for(var i=1; i<numPlayers+1; i++) Expanded(
                    child: Container(
                        height:30,
                        child: Text("Player"+i.toString()),
                        color: Colors.blue,
                    ),
                ),
              ]
            )

          ],
        ),
      )
    );
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