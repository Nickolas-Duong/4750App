import 'package:flutter/material.dart';
import 'dart:math';
import 'battles.dart';

class Battle6 extends StatefulWidget {
  final String title;
  final Battles battle;
  final int round;
  const Battle6({Key? key, required this.title, required this.battle, required this.round}) : super(key: key);

  @override
  State<Battle6> createState() => _Battle6();
}

class _Battle6 extends State<Battle6> {
  int userVP = 0;
  int oppVP = 0;
  List<int> _userMissionValues = [];
  List<int> userCurrentValues = [];
  List<int> _oppMissionValues = [];
  List<int> oppCurrentValues = [];

  @override
  void initState() {
    userVP = widget.battle.playerVP1;
    oppVP = widget.battle.opponentVP1;
  }

  // Define mission names, associated values, and limiters
  final Map<String, List<int>> missionValues = {
    'Confrontation': [3, 7],
    'Seize and Hold': [2, 5, 7],
    'No Man\'s Land': [3, 7, 11],
    'Hold Ground': [2, 5, 9],
    'Stronghold Assault': [4, 9, 7],
    'Devastation': [5, 3, 10],
    'Flanking Action': [2, 4, 8],
    'Retrieval': [5],
    'Forward Push': [3, 5, 9],
    'Conquest': [4, 5, 9],
    'All Out War': [3, 7],
    'Point Assault': [2, 7, 4],
  };

  // Define limiters for each mission
  final Map<String, int> missionLimiters = {
    'Confrontation': 3,
    'Seize and Hold': 2,
    'No Man\'s Land': 1,
    'Hold Ground': 1,
    'Stronghold Assault': 2,
    'Devastation': 2,
    'Flanking Action': 3,
    'Retrieval': 3,
    'Forward Push': 2,
    'Conquest': 6,
    'All Out War': 3,
    'Point Assault': 4,
  };

  void _next() {
    int round = widget.round;
    setState(() {
        int temp = 0;
        if (userCurrentValues.isNotEmpty) {
          for (int i = 0; i < userCurrentValues.length; i++) {
            temp += userCurrentValues[i];
          }
        }
        widget.battle.playerVP1 = temp;

        temp = 0;
        if (oppCurrentValues.isNotEmpty) {
          for (int i = 0; i < oppCurrentValues.length; i++) {
            temp += oppCurrentValues[i];
          }
        }
        widget.battle.opponentVP1 = temp;

      Navigator.pushNamed(
          context,
          '/battle7'
      );
    });
  }

  void updateUserVP() {
    setState((){
      userVP = 0;
      for (int i = 0; i < userCurrentValues.length; i++){
        userVP += userCurrentValues[i];
      }
    });
  }

  void updateOppVP() {
    setState((){
      oppVP = 0;
      for (int i = 0; i < oppCurrentValues.length; i++){
        oppVP += oppCurrentValues[i];
      }
    });
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
        children:[
          Positioned(
              left: width/2-40,
              top: height/5+15,
              child: Text('User\'s VP: $userVP')
          ),
          Positioned(
              left: width/2-50,
              top: height/3+35,
              child: const Text('Primary Mission')
          ),
          Positioned(
            left: width/2-50,
            top: height/4,
            child: InkWell(
              onTap: () {
                _userDialogBuilder(context);
              },
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                ),
                child: const Icon(Icons.add, size: 50),
              ),
            ),
          ),
          Positioned(
              left: width/2-60,
              top: height/5+215,
              child: Text('Opponent\'s VP: $oppVP')
          ),
          Positioned(
              left: width/2-50,
              top: height/3+235,
              child: const Text('Primary Mission')
          ),
          Positioned(
            left: width/2-50,
            top: height/4+200,
            child: InkWell(
              onTap: () {
                _oppDialogBuilder(context);
              },
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                ),
                child: const Icon(Icons.add, size: 50),
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


  Future<void> _userDialogBuilder(BuildContext context) async {
    String selectedMission = widget.battle.missionName ?? missionValues.keys.first;
    List<int> currentValues = List.filled(missionValues[selectedMission]!.length, 0);
    List<int> count = _userMissionValues.isNotEmpty ? List.from(_userMissionValues) : List.filled(missionValues[selectedMission]!.length, 0);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('User\'s Primary Mission: $selectedMission'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(missionValues[selectedMission]!.length, (index) {
                  int value = missionValues[selectedMission]![index];
                  currentValues[index] = count[index] * value;
                  return Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            currentValues[index] = max(0, currentValues[index] - value);
                            if(count[index] > 0){
                              count[index] = count[index] - 1;
                            }
                          });
                        },
                      ),
                      Text(currentValues[index].toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (count[index] < missionLimiters[selectedMission]!) {
                            setState(() {
                              currentValues[index] += value;
                              count[index]++;
                            });
                          }
                        },
                      ),
                    ],
                  );
                }),
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Confirm'),
                  onPressed: () {
                    _userMissionValues = List.from(count);
                    userCurrentValues = currentValues;
                    updateUserVP();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _oppDialogBuilder(BuildContext context) async {
    String selectedMission = widget.battle.missionName ?? missionValues.keys.first;
    List<int> currentValues = List.filled(missionValues[selectedMission]!.length, 0);
    List<int> count = _oppMissionValues.isNotEmpty ? List.from(_oppMissionValues) : List.filled(missionValues[selectedMission]!.length, 0);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Opponent\'s Primary Mission: $selectedMission'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(missionValues[selectedMission]!.length, (index) {
                  int value = missionValues[selectedMission]![index];
                  currentValues[index] = count[index] * value;
                  return Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            currentValues[index] = max(0, currentValues[index] - value);
                            if(count[index] > 0){
                              count[index] = count[index] - 1;
                            }
                          });
                        },
                      ),
                      Text(currentValues[index].toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          if (count[index] < missionLimiters[selectedMission]!) {
                            setState(() {
                              currentValues[index] += value;
                              count[index]++;
                            });
                          }
                        },
                      ),
                    ],
                  );
                }),
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Confirm'),
                  onPressed: () {
                    _oppMissionValues = List.from(count);
                    oppCurrentValues = currentValues;
                    updateOppVP();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}