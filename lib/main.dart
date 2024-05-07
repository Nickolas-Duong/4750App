import 'package:flutter/material.dart';
import 'battle1.dart';
import 'reviewbattles1.dart';
import 'viewstats.dart';
import 'battles.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'battle2.dart';
import 'battle3.dart';
import 'battle4.dart';
import 'battle5.dart';
import 'battle6.dart';
import 'battle7.dart';
import 'battle8.dart';
import 'battle9.dart';
import 'battle10.dart';
import 'endofbattle.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});


  @override
  Widget build(BuildContext context) {
    Battles battle = Battles();
    BattlesList battles = BattlesList();
    battles.loadBattles();
    return ChangeNotifierProvider(create: (context) => battles,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Epic Battles',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFFF), // Cyan
          secondary: Color(0xFFFF00FF), // Magenta
          surface: Color(0xFF333333), // Dark Gray
          background: Color(0xFF000000), // Black
          onBackground: Color(0xFFFFFFFF), // White
          onSurface: Color(0xFFFFFFFF), // White
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          // Add more text styles as needed
        ),
        fontFamily: 'Roboto',
      ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(title: "Epic Battles"),
          '/battle': (context) => Battle1(title: 'Start New Battle', battle: battle),
          '/battle2': (context) => Battle2(title: 'Start New Battle', battle: battle),
          '/battle3': (context) => Battle3(title: 'Start New Battle', battle: battle),
          '/battle4': (context) => Battle4(title: 'Start New Battle', battle: battle),
          '/battle5': (context) => Battle5(title: 'Start New Battle', battle: battle),
          '/battle6': (context) => Battle6(title: 'Round 1', battle: battle, round: 1),
          '/battle7': (context) => Battle7(title: 'Round 2', battle: battle, round: 2),
          '/battle8': (context) => Battle8(title: 'Round 3', battle: battle, round: 3),
          '/battle9': (context) => Battle9(title: 'Round 4', battle: battle, round: 4),
          '/battle10': (context) => Battle10(title: 'Round 5', battle: battle, round: 5),
          '/endofbattle': (context) => EndOfBattle(title: 'End of Battle', battle: battle),
          '/reviewbattle': (context) => ReviewBattles(title: 'Review Battles', battleList: battles._battles),
          '/viewstats': (context) => ViewStats(title: 'View Statistics', battleList: battles._battles),
        },
      )
    );
  }
}


class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    Database? inst = _database;
    if (inst != null) return inst;

    inst = await _initDatabase();
    _database = inst;
    return inst;
  }

  static Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = Path.join(documentsDirectory.path, "battles.db");

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS battles(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          playerName TEXT,
          playerFaction TEXT,
          opponentName TEXT,
          opponentFaction TEXT,
          playerVP1 INTEGER,
          opponentVP1 INTEGER,
          playerVP2 INTEGER,
          opponentVP2 INTEGER,
          playerVP3 INTEGER,
          opponentVP3 INTEGER,
          playerVP4 INTEGER,
          opponentVP4 INTEGER,
          playerVP5 INTEGER,
          opponentVP5 INTEGER,
          gameName TEXT,
          pointsPlayed INTEGER,
          missionName TEXT,
          userSecondary TEXT,
          oppSecondary TEXT,
          date TEXT
        )
      ''');
    });
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class BattlesList extends ChangeNotifier {
  List<Battles> _battles = [];

  List<Battles> get battles => _battles;

  Future<void> loadBattles() async {
    final db = await DatabaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('battles');

    _battles = List.generate(maps.length, (i) {
      Battles battle = Battles(
        playerName: maps[i]['playerName'],
        playerFaction: maps[i]['playerFaction'],
        opponentName: maps[i]['opponentName'],
        opponentFaction: maps[i]['opponentFaction'],
        playerVP1: maps[i]['playerVP1'],
        playerVP2: maps[i]['playerVP2'],
        playerVP3: maps[i]['playerVP3'],
        playerVP4: maps[i]['playerVP4'],
        playerVP5: maps[i]['playerVP5'],
        opponentVP1: maps[i]['opponentVP1'],
        opponentVP2: maps[i]['opponentVP2'],
        opponentVP3: maps[i]['opponentVP3'],
        opponentVP4: maps[i]['opponentVP4'],
        opponentVP5: maps[i]['opponentVP5'],
        gameName: maps[i]['gameName'],
        pointsPlayed: maps[i]['pointsPlayed'],
        missionName: maps[i]['missionName'],
        userSecondary: maps[i]['userSecondary'],
        oppSecondary: maps[i]['oppSecondary'],
        date: DateTime.parse(maps[i]['date']),
      );
      return battle;
    });

    notifyListeners();
  }


  void addBattle(Battles battle) {
    _battles.add(battle);
    notifyListeners();
  }

  void replaceBattles(List<Battles> newBattles) {
    _battles = newBattles;
    notifyListeners();
  }
}

Future<void> deleteAllEntries(BuildContext context) async {
  // Get a location using getDatabasesPath()
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final path = Path.join(documentsDirectory.path, "battles.db");

  // Open the database
  Database database = await openDatabase(path, version: 1);

  // Delete all entries from the table
  await database.delete('battles');

  BattlesList battles = Provider.of<BattlesList>(context, listen: false);
  battles.loadBattles();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Battles> allBattles = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addBattle(Battles battle) {
    setState(() {
      allBattles.add(battle);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(widget.title),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: width / 2 - 125,
            top: height / 4+300,
            child: InkWell(
              onTap: () {
                _showDeleteConfirmationDialog(context);
              },
              child: Container(
                width: 250,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: const Text(
                  'Delete All Battle Data',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Positioned(
            left: width / 2 - 125,
            top: height / 4,
            child: InkWell(
              onTap: () {
                setState(() {
                  Navigator.pushNamed(
                    context,
                      '/battle'
                  );
                });
              },
              child: Container(
                width: 250,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: const Text(
                  'Start New Battle',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Positioned(
            left: width / 2 - 125,
            top: height / 4 + 100,
            child: InkWell(
              onTap: () {
                setState(() {
                  Navigator.pushNamed(
                    context, '/reviewbattle'
                  );
                });
              },
              child: Container(
                width: 250,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: const Text(
                  'Review Battles',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Positioned(
            left: width / 2 - 125,
            top: height / 4 + 200,
            child: InkWell(
              onTap: () {
                setState(() {
                  Navigator.pushNamed(
                      context,
                      '/viewstats'
                  );
                });
              },
              child: Container(
                width: 250,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: const Text(
                  'View Statistics',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showDeleteConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete All Data?'),
        content: Text('Are you sure you want to delete all data?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Call the function to delete all entries
              await deleteAllEntries(context);
                Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: Text('Confirm'),
          ),
        ],
      );
    },
  );
}