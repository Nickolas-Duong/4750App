import 'package:flutter/material.dart';
import 'battles.dart';

class Battle2 extends StatefulWidget {
  final String title;
  final Battles battle;

  const Battle2({Key? key, required this.title, required this.battle}) : super(key: key);

  @override
  State<Battle2> createState() => _Battle2State();
}

class _Battle2State extends State<Battle2> {
  final TextEditingController _playerNameController = TextEditingController();
  final TextEditingController _playerFactionController = TextEditingController();
  final TextEditingController _opponentNameController = TextEditingController();
  final TextEditingController _opponentFactionController = TextEditingController();

  void _next() {
    // Get the values from the text fields
    String playerName = _playerNameController.text;
    String playerFaction = _playerFactionController.text;
    String opponentName = _opponentNameController.text;
    String opponentFaction = _opponentFactionController.text;

    // Set the values to the Battles instance
    widget.battle.playerName = playerName;
    widget.battle.playerFaction = playerFaction;
    widget.battle.opponentName = opponentName;
    widget.battle.opponentFaction = opponentFaction;

    // Navigate to the next page
    Navigator.pushNamed(
        context,
        '/battle3'
    );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _playerNameController.dispose();
    _playerFactionController.dispose();
    _opponentNameController.dispose();
    _opponentFactionController.dispose();
    super.dispose();
  }

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
        alignment: Alignment.center,
        children: [
          Positioned(
            left: width / 2 - 125,
            top: height / 7,
            child: Container(
              width: 250,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey,
              ),
              child: TextField(
                controller: _playerNameController,
                decoration: const InputDecoration(labelText: "Player's Name:"),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          Positioned(
            left: width / 2 - 125,
            top: height / 7 + 125,
            child: Container(
              width: 250,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey,
              ),
              child: TextField(
                controller: _playerFactionController,
                decoration: const InputDecoration(labelText: "Player's Faction:"),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          Positioned(
            left: width / 2 - 125,
            top: height / 7 + 250,
            child: Container(
              width: 250,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey,
              ),
              child: TextField(
                controller: _opponentNameController,
                decoration: const InputDecoration(labelText: "Opponent's Name:"),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
          Positioned(
            left: width / 2 - 125,
            top: height / 7 + 375,
            child: Container(
              width: 250,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey,
              ),
              child: TextField(
                controller: _opponentFactionController,
                decoration: const InputDecoration(labelText: "Opponent's Faction:"),
                keyboardType: TextInputType.text,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _next,
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_forward_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
