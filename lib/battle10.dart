import 'package:flutter/material.dart';
import 'dart:math';
import 'battles.dart';


class Battle10 extends StatefulWidget {
  final String title;
  final Battles battle;
  final int round;
  const Battle10({Key? key, required this.title, required this.battle, required this.round}) : super(key: key);

  @override
  State<Battle10> createState() => _Battle10();
}

class _Battle10 extends State<Battle10> {
  int _userSecondary = 0;
  int _oppSecondary = 0;
  int userVP = 0;
  int oppVP = 0;
  List<int> _userMissionValues = [];
  List<int> userCurrentValues = [];
  List<int> _oppMissionValues = [];
  List<int> oppCurrentValues = [];

  @override
  void initState() {
    userVP = widget.battle.playerVP1 + widget.battle.playerVP2 + widget.battle.playerVP3 + widget.battle.playerVP4 + widget.battle.playerVP5;
    oppVP = widget.battle.opponentVP1 + widget.battle.opponentVP2 + widget.battle.opponentVP3 + widget.battle.opponentVP4 + widget.battle.opponentVP5;
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
      widget.battle.playerVP5 = temp + _userSecondary;

      temp = 0;
      if (oppCurrentValues.isNotEmpty) {
        for (int i = 0; i < oppCurrentValues.length; i++) {
          temp += oppCurrentValues[i];
        }
      }
      widget.battle.opponentVP5 = temp + _oppSecondary;

      Navigator.pushNamed(
          context,
          '/endofbattle'
      );
    });
  }

  void updateUserVP() {
    setState((){
      userVP = widget.battle.playerVP1 + widget.battle.playerVP2 + widget.battle.playerVP3 + widget.battle.playerVP4 + widget.battle.playerVP5 + _userSecondary;
      for (int i = 0; i < userCurrentValues.length; i++){
        userVP += userCurrentValues[i];
      }
    });
  }

  void updateOppVP() {
    setState((){
      oppVP = widget.battle.opponentVP1 + widget.battle.opponentVP2 + widget.battle.opponentVP3 + widget.battle.opponentVP4 + widget.battle.opponentVP5 + _oppSecondary;
      for (int i = 0; i < oppCurrentValues.length; i++){
        oppVP += oppCurrentValues[i];
      }
    });
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              left: width / 2 - 40,
              top: height / 5 + 15,
              child: Text('User\'s VP: $userVP')
          ),
          Positioned(
              left: width / 2 - 115,
              top: height / 3 + 35,
              child: const Text('Primary Mission')
          ),
          Positioned(
            left: width / 2 + 10,
            top: height / 4,
            child: InkWell(
              onTap: () {
                setState(() {
                  _userSecDialogBuilder(context);
                });
              },
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                ),
                child: const Icon(Icons.add, size: 50),
              ),
            ),
          ),
          Positioned(
              left: width / 2,
              top: height / 3 + 35,
              child: const Text('Secondary Mission')
          ),
          Positioned(
            left: width / 2 - 110,
            top: height / 4,
            child: InkWell(
              onTap: () {
                setState(() {
                  _userDialogBuilder(context);
                });
              },
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                ),
                child: const Icon(Icons.add, size: 50),
              ),
            ),
          ),
          Positioned(
              left: width / 2 - 60,
              top: height / 5 + 215,
              child: Text('Opponent\'s VP: $oppVP')
          ),
          Positioned(
              left: width / 2 - 115,
              top: height / 3 + 235,
              child: const Text('Primary Mission')
          ),
          Positioned(
            left: width / 2 + 10,
            top: height / 4 + 200,
            child: InkWell(
              onTap: () {
                setState(() {
                  _oppSecDialogBuilder(context);
                });
              },
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                ),
                child: const Icon(Icons.add, size: 50),
              ),
            ),
          ),
          Positioned(
              left: width / 2,
              top: height / 3 + 235,
              child: const Text('Secondary Mission')
          ),
          Positioned(
            left: width / 2 - 110,
            top: height / 4 + 200,
            child: InkWell(
              onTap: () {
                setState(() {
                  _oppDialogBuilder(context);
                });
              },
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1
                  ),
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

  Future<void> _userSecDialogBuilder(BuildContext context) async {
    // Retrieve the currently selected value from Battles or use the default value
    int userSecondary = _userSecondary ?? 0;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('User\'s Secondary Mission'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Wrap(
                    children: <Widget>[
                      ChoiceChip(
                        label: const Text('0'),
                        selected: userSecondary == 0,
                        selectedColor: Colors.grey.shade800,
                        onSelected: (bool selected) {
                          setState(() {
                            userSecondary = 0;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text('5'),
                        selected: userSecondary == 5,
                        selectedColor: Colors.grey.shade800,
                        onSelected: (bool selected) {
                          setState(() {
                            userSecondary = 5;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text('10'),
                        selected: userSecondary == 10,
                        selectedColor: Colors.grey.shade800,
                        onSelected: (bool selected) {
                          setState(() {
                            userSecondary = 10;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text('15'),
                        selected: userSecondary == 15,
                        selectedColor: Colors.grey.shade800,
                        onSelected: (bool selected) {
                          setState(() {
                            userSecondary = 15;
                          });
                        },

                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme
                        .of(context)
                        .textTheme
                        .labelLarge,
                  ),
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme
                        .of(context)
                        .textTheme
                        .labelLarge,
                  ),
                  child: const Text('Confirm'),
                  onPressed: () {
                    // Update the value in Battles battle
                    _userSecondary = userSecondary;
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

  Future<void> _oppSecDialogBuilder(BuildContext context) async {
    // Retrieve the currently selected value from Battles or use the default value
    int oppSecondary = _oppSecondary ?? 0;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Opponent\'s Secondary Mission'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                      ChoiceChip(
                        label: const Text('0'),
                        selected: oppSecondary == 0,
                        selectedColor: Colors.grey.shade800,
                        onSelected: (bool selected) {
                          setState(() {
                            oppSecondary = 0;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text('5'),
                        selected: oppSecondary == 5,
                        selectedColor: Colors.grey.shade800,
                        onSelected: (bool selected) {
                          setState(() {
                            oppSecondary = 5;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text('10'),
                        selected: oppSecondary == 10,
                        selectedColor: Colors.grey.shade800,
                        onSelected: (bool selected) {
                          setState(() {
                            oppSecondary = 10;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text('15'),
                        selected: oppSecondary == 15,
                        selectedColor: Colors.grey.shade800,
                        onSelected: (bool selected) {
                          setState(() {
                            oppSecondary = 15;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme
                        .of(context)
                        .textTheme
                        .labelLarge,
                  ),
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme
                        .of(context)
                        .textTheme
                        .labelLarge,
                  ),
                  child: const Text('Confirm'),
                  onPressed: () {
                    // Update the value in Battles battle
                    _oppSecondary = oppSecondary;
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