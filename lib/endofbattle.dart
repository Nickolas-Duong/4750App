import 'battles.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
class EndOfBattle extends StatefulWidget {
  final String title;
  final Battles battle;
  const EndOfBattle({Key? key, required this.title, required this.battle}) : super(key: key);

  @override
  State<EndOfBattle> createState() => _EndOfBattleState();
}

class _EndOfBattleState extends State<EndOfBattle> {
  final Battles _battle = Battles();
  int userVP = 0;
  int oppVP = 0;
  final List<String> _winTitle = ['Win', 'Loss', 'Draw'];
  List<int> _playerVPList = [];
  List<int> _opponentVPList = [];

  void _next() async {
    final db = await DatabaseHelper.database;

    await db.insert('battles', {
      'playerName': _battle.playerName,
      'playerFaction': _battle.playerFaction,
      'opponentName': _battle.opponentName,
      'opponentFaction': _battle.opponentFaction,
      'playerVP1': _battle.playerVP1,
      'playerVP2': _battle.playerVP2,
      'playerVP3': _battle.playerVP3,
      'playerVP4': _battle.playerVP4,
      'playerVP5': _battle.playerVP5,
      'opponentVP1': _battle.opponentVP1,
      'opponentVP2': _battle.opponentVP2,
      'opponentVP3': _battle.opponentVP3,
      'opponentVP4': _battle.opponentVP4,
      'opponentVP5': _battle.opponentVP5,
      'gameName': _battle.gameName,
      'pointsPlayed': _battle.pointsPlayed,
      'missionName': _battle.missionName,
      'userSecondary': _battle.userSecondary,
      'oppSecondary': _battle.oppSecondary,
      'date': _battle.date.toIso8601String(),
    });

    BattlesList battlesList = Provider.of<BattlesList>(context, listen: false);
    battlesList.addBattle(_battle); // Add the given battle to the BattlesList
    setState(() {
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }

  @override
  void initState() {
    super.initState();
    _calculatePoints();
    _battle.copyFrom(widget.battle);
  }

  void _calculatePoints() {
    // Calculate sum of player and opponent VP
    setState(() {
      userVP = widget.battle.playerVP1 +
          widget.battle.playerVP2 +
          widget.battle.playerVP3 +
          widget.battle.playerVP4 +
          widget.battle.playerVP5;
      oppVP = widget.battle.opponentVP1 +
          widget.battle.opponentVP2 +
          widget.battle.opponentVP3 +
          widget.battle.opponentVP4 +
          widget.battle.opponentVP5;

      _playerVPList = [
        widget.battle.playerVP1,
        widget.battle.playerVP2,
        widget.battle.playerVP3,
        widget.battle.playerVP4,
        widget.battle.playerVP5
      ]; // Copy playerVP list

      _opponentVPList = [
        widget.battle.opponentVP1,
        widget.battle.opponentVP2,
        widget.battle.opponentVP3,
        widget.battle.opponentVP4,
        widget.battle.opponentVP5
      ]; // Copy opponentVP list
    });
  }

  TableRow buildRow(List<String> cells) => TableRow(
    children: cells
        .map((cell) => Padding(
      padding: const EdgeInsets.all(3),
      child: Center(
        child: Text(
          cell,
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
    ))
        .toList(),
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  (userVP > oppVP)
                      ? 'Win!'
                      : (userVP < oppVP)
                      ? 'Lose...'
                      : 'Tie...',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: (userVP > oppVP)
                        ? Colors.green
                        : (userVP < oppVP)
                        ? Colors.red
                        : Colors.white,
                  ),
                ),
                Text(
                  'Mission: ${widget.battle.missionName}',
                  style: const TextStyle(fontSize: 20.0),
                ),
                Text(
                  'User Secondary: ${widget.battle.userSecondary}',
                  style: const TextStyle(fontSize: 20.0),
                ),
                Text(
                  'Opponent Secondary: ${widget.battle.oppSecondary}',
                  style: const TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          ),
          Positioned(
            left: width / 2 - 60,
            top: height / 5 + 15,
            child: const Text(
              'User\'s Score',
              style: TextStyle(fontSize: 20.0, color: Colors.green),
            ),
          ),
          Positioned(
            left: width / 7 + 10,
            top: height / 5 + 40,
            child: SizedBox(
              width: 275,
              height: 100,
              child: Table(
                border: TableBorder.all(),
                children: [
                  buildRow(['Round 1', 'Round 2', 'Round 3']),
                  buildRow([
                    '${_playerVPList[0]}',
                    '${_playerVPList[1]}',
                    '${_playerVPList[2]}'
                  ]),
                  buildRow(['Round 4', 'Round 5', 'Total']),
                  buildRow([
                    '${_playerVPList[3]}',
                    '${_playerVPList[4]}',
                    '$userVP'
                  ]),
                ],
              ),
            ),
          ),
          Positioned(
            left: width / 2 - 75,
            top: height / 5 + 215,
            child: const Text(
              'Opponent\'s Score:',
              style: TextStyle(fontSize: 20.0, color: Colors.red),
            ),
          ),
          Positioned(
            left: width / 7 + 10,
            top: height / 5 + 240,
            child: SizedBox(
              width: 275,
              height: 100,
              child: Table(
                border: TableBorder.all(),
                children: [
                  buildRow(['Round 1', 'Round 2', 'Round 3']),
                  buildRow([
                    '${_opponentVPList[0]}',
                    '${_opponentVPList[1]}',
                    '${_opponentVPList[2]}'
                  ]),
                  buildRow(['Round 4', 'Round 5', 'Total']),
                  buildRow([
                    '${_opponentVPList[3]}',
                    '${_opponentVPList[4]}',
                    '$oppVP'
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _next,
        tooltip: 'Increment',
        child: const Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}