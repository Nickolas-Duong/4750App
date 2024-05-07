import 'package:flutter/material.dart';
import 'battles.dart';


class ViewStats extends StatefulWidget {
  const ViewStats({super.key, required this.title, required this.battleList});
  final String title;
  final List<Battles> battleList;

  @override
  State<ViewStats> createState() => _ViewStats();
}

class _ViewStats extends State<ViewStats> {
  int getTotalBattles() {
    return widget.battleList.length;
  }

  Map<String, int> getWinLossTieCount() {
    int winCount = 0;
    int lossCount = 0;
    int tieCount = 0;

    for (var battle in widget.battleList) {
      int userVP = battle.playerVP1 + battle.playerVP2 + battle.playerVP3 + battle.playerVP4 + battle.playerVP5;
      int oppVP = battle.opponentVP1+battle.opponentVP2 + battle.opponentVP3+battle.opponentVP4+battle.opponentVP5;

      if (userVP > oppVP) {
        winCount++;
      } else if (userVP < oppVP) {
        lossCount++;
      } else {
        tieCount++;
      }
    }

    return {'Win': winCount, 'Loss': lossCount, 'Tie': tieCount};
  }

  double getWinRatio() {
    int totalBattles = getTotalBattles();
    Map<String, int> winLossTieCount = getWinLossTieCount();
    int winCount = winLossTieCount['Win'] ?? 0;

    return totalBattles > 0 ? winCount / totalBattles : 0.0;
  }

  String getMostPlayedFaction() {
    Map<String, int> factionCount = {};

    for (var battle in widget.battleList) {
      factionCount[battle.playerFaction] =
          (factionCount[battle.playerFaction] ?? 0) + 1;
    }

    // Find the faction with the maximum count
    var mostPlayedFaction = factionCount.entries.reduce((a, b) =>
    a.value > b.value ? a : b);

    return mostPlayedFaction.key;
  }

  double getAverageVPScored() {
    int totalBattles = getTotalBattles();
    int totalVPScored = 0;

    for (var battle in widget.battleList) {
      totalVPScored +=
        battle.playerVP1 + battle.playerVP2 + battle.playerVP3 + battle.playerVP4 + battle.playerVP5;
    }

    return totalBattles > 0 ? totalVPScored / (totalBattles * 5) : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;

    // Check if battleList is empty
    bool isEmpty = widget.battleList.isEmpty;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Positioned(
            width: width,
            top: height - 800,
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                color: Colors.grey.shade800,
              ),
              child: Text('Battles Played: ${isEmpty ? 0 : getTotalBattles()}'),
            ),
          ),
          Positioned(
            width: width,
            top: height - 725,
            child: Container(
              width: 50,
              height: 75,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                color: Colors.grey.shade800,
              ),
              child: Text(
                  'Win: ${isEmpty ? 0 : getWinLossTieCount()['Win'] ?? 0}\n'
                      'Loss: ${isEmpty ? 0 : getWinLossTieCount()['Loss'] ??
                      0}\n'
                      'Tie: ${isEmpty ? 0 : getWinLossTieCount()['Tie'] ?? 0}'),
            ),
          ),
          Positioned(
            width: width,
            top: height - 625,
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                color: Colors.grey.shade800,
              ),
              child: Text(
                  'Win Ratio\n${isEmpty ? 0.0 : getWinRatio().toStringAsFixed(
                      2)}'),
            ),
          ),
          Positioned(
            width: width,
            top: height - 550,
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                color: Colors.grey.shade800,
              ),
              child: Text('Most Played Faction\n${isEmpty
                  ? "No data"
                  : getMostPlayedFaction()}'),
            ),
          ),
          Positioned(
            width: width,
            top: height - 475,
            child: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1),
                color: Colors.grey.shade800,
              ),
              child: Text('Average VP Scored Per Round\n${isEmpty
                  ? 0.0
                  : getAverageVPScored().toStringAsFixed(2)}'),
            ),
          ),
        ],
      ),
    );
  }
}