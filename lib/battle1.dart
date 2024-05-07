import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'battles.dart';

class Battle1 extends StatefulWidget {
  const Battle1({Key? key, required this.title, required this.battle}) : super(key: key);
  final Battles battle;

  final String title;

  @override
  State<Battle1> createState() => _Battle1State();
}

class _Battle1State extends State<Battle1> {
  String? _selectedGameName;

  void _next() {
    // Get the points value from the text field
    String pointsValue = _pointsController.text;
    // Convert it to an integer
    int points = int.tryParse(pointsValue) ?? 0;

    setState(() {
      // Set the pointsPlayed and gameName properties of the Battles instance
      widget.battle.pointsPlayed = points;
      widget.battle.gameName = _selectedGameName ?? '';

      Navigator.pushNamed(
        context,
        '/battle2'
      );
    });
  }

  final TextEditingController _pointsController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _pointsController.dispose();
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
            top: height / 4 + 100,
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
                controller: _pointsController,
                decoration: const InputDecoration(labelText: "Points Value:"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ),
          Positioned(
            left: width / 2 - 125,
            top: height / 4 -50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Game Name:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 250,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey,
                  ),
                  child: DropdownButton<String>(
                    value: _selectedGameName,
                    items: <String>['Legions Imperialis'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedGameName = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _next,
        tooltip: 'Next Page',
        child: const Icon(Icons.arrow_forward_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}