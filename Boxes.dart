import 'package:hive/hive.dart';
import 'package:scorer/Game.dart';
import'package:scorer/player.dart';

class Boxes {
  static Box<Game> getGames() =>
      Hive.box<Game>('games');

  static Box<Player> getPlayers() =>
      Hive.box<Player>('players');
}