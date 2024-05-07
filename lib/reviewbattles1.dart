import 'package:flutter/material.dart';
import 'battles.dart';
import 'endofbattle2.dart';

class ReviewBattles extends StatefulWidget {
  final String title;
  final List<Battles> battleList;

  const ReviewBattles({Key? key, required this.title, required this.battleList})
      : super(key: key);

  @override
  _ReviewBattlesState createState() => _ReviewBattlesState();
}

class _ReviewBattlesState extends State<ReviewBattles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: widget.battleList.length,
        itemBuilder: (context, index) {
          return SelectableItem(
            battle: widget.battleList[index],
          );
        },
      ),
    );
  }
}

class SelectableItem extends StatefulWidget {
  final Battles battle;

  const SelectableItem({Key? key, required this.battle}) : super(key: key);

  @override
  _SelectableItemState createState() => _SelectableItemState();
}

class _SelectableItemState extends State<SelectableItem> {
  final bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isSelected ? Colors.blue : Colors.white, // Change color based on selection
        borderRadius: BorderRadius.circular(8), // Adjust border radius as needed
        border: Border.all(
          color: Colors.white, // White outline
          width: 1,
        ),
      ),
      child: ListTile(
        title: Text(
          '${widget.battle.date.month}/${widget.battle.date.day}/${widget.battle.date.year}',
          style: TextStyle(
            color: _isSelected ? Colors.white : Colors.black, // Change text color based on selection
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Player: ${widget.battle.playerName}',
              style: TextStyle(
                color: _isSelected ? Colors.white : Colors.black, // Adjust text color based on selection
              ),
            ),
            Text(
              'Opponent: ${widget.battle.opponentName}',
              style: TextStyle(
                color: _isSelected ? Colors.white : Colors.black, // Adjust text color based on selection
              ),
            ),
            Text(
              'Points: ${widget.battle.pointsPlayed}',
              style: TextStyle(
                color: _isSelected ? Colors.white : Colors.black, // Adjust text color based on selection
              ),
            ),
          ],
        ),
        trailing: _isSelected ? const Icon(Icons.check_circle, color: Colors.white) : null, // White check icon
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EndOfBattle2(
                title: 'End of Battle',
                battle: widget.battle, // Pass the selected battle to the EndOfBattle route
              ),
            ),
          );
        },
      ),
    );
  }
}
