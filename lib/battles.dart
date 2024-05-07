class Battles {
  String _playerName = '';
  String _playerFaction = '';
  String _opponentName = '';
  String _opponentFaction = '';
  String _gameName = '';
  int _pointsPlayed = 0;
  String _missionName = '';
  String _userSecondary = '';
  String _oppSecondary = '';
  DateTime _date = DateTime.now();

  // Properties for player and opponent VP for each round
  int _playerVP1 = 0;
  int _playerVP2 = 0;
  int _playerVP3 = 0;
  int _playerVP4 = 0;
  int _playerVP5 = 0;

  int _opponentVP1 = 0;
  int _opponentVP2 = 0;
  int _opponentVP3 = 0;
  int _opponentVP4 = 0;
  int _opponentVP5 = 0;

  // Constructor
  Battles({
    String playerName = '',
    String playerFaction = '',
    String opponentName = '',
    String opponentFaction = '',
    String gameName = '',
    int pointsPlayed = 0,
    String missionName = '',
    String userSecondary = '',
    String oppSecondary = '',
    DateTime? date,
    int playerVP1 = 0,
    int playerVP2 = 0,
    int playerVP3 = 0,
    int playerVP4 = 0,
    int playerVP5 = 0,
    int opponentVP1 = 0,
    int opponentVP2 = 0,
    int opponentVP3 = 0,
    int opponentVP4 = 0,
    int opponentVP5 = 0,
  })  : _playerName = playerName,
        _playerFaction = playerFaction,
        _opponentName = opponentName,
        _opponentFaction = opponentFaction,
        _gameName = gameName,
        _pointsPlayed = pointsPlayed,
        _missionName = missionName,
        _userSecondary = userSecondary,
        _oppSecondary = oppSecondary,
        _date = date ?? DateTime.now(),
        _playerVP1 = playerVP1,
        _playerVP2 = playerVP2,
        _playerVP3 = playerVP3,
        _playerVP4 = playerVP4,
        _playerVP5 = playerVP5,
        _opponentVP1 = opponentVP1,
        _opponentVP2 = opponentVP2,
        _opponentVP3 = opponentVP3,
        _opponentVP4 = opponentVP4,
        _opponentVP5 = opponentVP5;

  // Getters
  String get playerName => _playerName;
  String get playerFaction => _playerFaction;
  String get opponentName => _opponentName;
  String get opponentFaction => _opponentFaction;
  String get gameName => _gameName;
  int get pointsPlayed => _pointsPlayed;
  String get missionName => _missionName;
  String get userSecondary => _userSecondary;
  String get oppSecondary => _oppSecondary;
  DateTime get date => _date;

  // Getters for player and opponent VP for each round
  int get playerVP1 => _playerVP1;
  int get playerVP2 => _playerVP2;
  int get playerVP3 => _playerVP3;
  int get playerVP4 => _playerVP4;
  int get playerVP5 => _playerVP5;

  int get opponentVP1 => _opponentVP1;
  int get opponentVP2 => _opponentVP2;
  int get opponentVP3 => _opponentVP3;
  int get opponentVP4 => _opponentVP4;
  int get opponentVP5 => _opponentVP5;

  // Setters
  set playerName(String value) => _playerName = value;
  set playerFaction(String value) => _playerFaction = value;
  set opponentName(String value) => _opponentName = value;
  set opponentFaction(String value) => _opponentFaction = value;
  set gameName(String value) => _gameName = value;
  set pointsPlayed(int value) => _pointsPlayed = value;
  set missionName(String value) => _missionName = value;
  set userSecondary(String value) => _userSecondary = value;
  set oppSecondary(String value) => _oppSecondary = value;
  set date(DateTime value) => _date = value;

  // Setters for player and opponent VP for each round
  set playerVP1(int value) => _playerVP1 = value;
  set playerVP2(int value) => _playerVP2 = value;
  set playerVP3(int value) => _playerVP3 = value;
  set playerVP4(int value) => _playerVP4 = value;
  set playerVP5(int value) => _playerVP5 = value;

  set opponentVP1(int value) => _opponentVP1 = value;
  set opponentVP2(int value) => _opponentVP2 = value;
  set opponentVP3(int value) => _opponentVP3 = value;
  set opponentVP4(int value) => _opponentVP4 = value;
  set opponentVP5(int value) => _opponentVP5 = value;

  // Convert battles object to JSON
  Map<String, dynamic> toJson() {
    return {
      'playerName': _playerName,
      'playerFaction': _playerFaction,
      'opponentName': _opponentName,
      'opponentFaction': _opponentFaction,
      'gameName': _gameName,
      'pointsPlayed': _pointsPlayed,
      'missionName': _missionName,
      'userSecondary': _userSecondary,
      'oppSecondary': _oppSecondary,
      'date': _date.toIso8601String(),
      'playerVP1': _playerVP1,
      'playerVP2': _playerVP2,
      'playerVP3': _playerVP3,
      'playerVP4': _playerVP4,
      'playerVP5': _playerVP5,
      'opponentVP1': _opponentVP1,
      'opponentVP2': _opponentVP2,
      'opponentVP3': _opponentVP3,
      'opponentVP4': _opponentVP4,
      'opponentVP5': _opponentVP5,
    };
  }

  // Create battles object from JSON
  factory Battles.fromJson(Map<String, dynamic> json) {
    return Battles(
      playerName: json['playerName'],
      playerFaction: json['playerFaction'],
      opponentName: json['opponentName'],
      opponentFaction: json['opponentFaction'],
      gameName: json['gameName'],
      pointsPlayed: json['pointsPlayed'],
      missionName: json['missionName'],
      userSecondary: json['userSecondary'],
      oppSecondary: json['oppSecondary'],
      date: DateTime.parse(json['date']),
      playerVP1: json['playerVP1'],
      playerVP2: json['playerVP2'],
      playerVP3: json['playerVP3'],
      playerVP4: json['playerVP4'],
      playerVP5: json['playerVP5'],
      opponentVP1: json['opponentVP1'],
      opponentVP2: json['opponentVP2'],
      opponentVP3: json['opponentVP3'],
      opponentVP4: json['opponentVP4'],
      opponentVP5: json['opponentVP5'],
    );
  }

  void copyFrom(Battles other) {
    _playerName = other._playerName;
    _playerFaction = other._playerFaction;
    _opponentName = other._opponentName;
    _opponentFaction = other._opponentFaction;
    _playerVP1 = other._playerVP1;
    _playerVP2 = other._playerVP2;
    _playerVP3 = other._playerVP3;
    _playerVP4 = other._playerVP4;
    _playerVP5 = other._playerVP5;
    _opponentVP1 = other._opponentVP1;
    _opponentVP2 = other._opponentVP2;
    _opponentVP3 = other._opponentVP3;
    _opponentVP4 = other._opponentVP4;
    _opponentVP5 = other._opponentVP5;
    _gameName = other._gameName;
    _pointsPlayed = other._pointsPlayed;
    _missionName = other._missionName;
    _userSecondary = other._userSecondary;
    _oppSecondary = other._oppSecondary;
    _date = other._date;
  }
}
