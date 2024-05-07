import 'package:flutter/material.dart';
import 'dart:math';
import 'battles.dart';

class Battle4 extends StatefulWidget {
  final String title;
  final Battles battle;

  const Battle4({Key? key, required this.title, required this.battle}) : super(key: key);

  @override
  State<Battle4> createState() => _Battle4();
}

class _Battle4 extends State<Battle4> {
  int _select = 0;
  final List<String> _selections = ['Carnage','Vital Intel', 'Control the Battlefield',
    'Breakthrough', 'Plant the Standard', 'Defiant'];

  void _next() {
    widget.battle.userSecondary = _selections[_select];
    setState(() {
      Navigator.pushNamed(
          context,
          '/battle5'
      );
    });
  }

  void _randomChoice(){
    var range = Random();
    _select = range.nextInt(_selections.length);
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
        children:[
          Positioned(
              left: width/50,
              top: height/4,
              child: SizedBox(
                height: 600,
                width: 200,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _selections.length,
                  itemBuilder: (BuildContext context, int index){
                  return ChoiceChip(
                    label: Text(_selections[index]),
                      selected: _select == index,
                    selectedColor: Colors.grey.shade800, // Set selection color to dark grey
                    onSelected: (value){
                      setState(() {
                        _select = value ? index : 0;
                      });
                    },
                   );
                  },
              )
            ),
          ),
          Positioned(
            left: width/2+50,
            top: height/2-100,
            child: InkWell(
              onTap: (){
                setState(() {
                  _randomChoice();
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
                child: const Icon(Icons.repeat, size: 50),
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
