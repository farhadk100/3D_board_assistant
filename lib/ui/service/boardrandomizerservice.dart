import 'dart:math';

import 'package:board_assistant/enum/direction.dart';
import 'package:board_assistant/ui/service/boardbase.dart';
import 'package:board_assistant/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BoardRandomizerService extends BoardBase{

  FlutterTts? _flutterTts = FlutterTts();
  bool _isTalking = false;
  int _speechRate = 4;
  int get speechRate => _speechRate;
  set speechRate(int value) {
    _speechRate = value;
    _flutterTts?.setSpeechRate(_speechRate/10);
    notifyListeners();
  }

  int _pauseSeconds = 5;

  bool _cancelReading = false;

  List<int> _stack = [];
  List<int> _visitedRooms = [];

  final List<int> _canBeTiles = [0, 2, 4,6, 14,16,18,20,28,30,32,34,42,44,46,48];

  List<String> _board = List.filled(49, Constants.boardEmpty);
  List<String> get board => _board;

  int _totalWallsAvailable = 7;
  int get totalWallsAvailable => _totalWallsAvailable;
  set totalWallsAvailable(value){
    _totalWallsAvailable = value;
    notifyListeners();
  }

  BoardRandomizerService() {
    generateBoard();
  }

  @override
  dispose(){
    _flutterTts?.awaitSpeakCompletion(false);
    _flutterTts?.stop();
    super.dispose();
  }

  Future<void> generateBoard() async {
    _board = List.filled(49, Constants.boardEmpty);
    do {
      tiles.shuffle();
    } while (!_foundInSlot(Constants.boardTileEntrance, [0,1,2,3,4,7,8,11,12,13,14,15]) ||
        !_foundInSlot(Constants.boardTileVault, [0,1,2,3,4,7,8,11,12,13,14,15]) ||
        !_hasDirectAccess(Constants.boardTileSecurityRoom, Constants.boardTileVault) ||
        _hasDirectAccess(Constants.boardTileVault, Constants.boardTileRooftop) ||
        _hasDirectAccess(Constants.boardTileVault, Constants.boardTileEntrance)
    );
    await _pathGenerator();
    _securityWallRemover();
    _wallCleaner();
    _setToBoard();
    notifyListeners();
  }

  Future<void> _pathGenerator() async {
    wallSituation.forEach((key, value) {
      wallSituation[key] = true;
    });
    _visitedRooms = [];
    _stack = [];
    int currentRoom = -1;
    Map<int, List<int>> tempDirectAccess = <int, List<int>>{};
    slotsWithDirectAccess.forEach((key, value) {
      tempDirectAccess[key] = [];
      for (int num in value){
        tempDirectAccess[key]?.add(num);
      }
    });
    List<int> keys = [];
    int vaultKey = tiles.indexOf(Constants.boardTileVault);
    tempDirectAccess.remove(vaultKey);
    tempDirectAccess.forEach((key, value) {
      keys.add(key);
      value.shuffle();
      value.removeWhere((element) => element == vaultKey);
    });
    keys.shuffle();
    currentRoom = keys[0];
    _stack.add(keys[0]);
    while (_stack.isNotEmpty){
      List<int> neighbours = tempDirectAccess[currentRoom]!;
      neighbours.shuffle();
      bool allNeighboursVisited = true;
      for (int neighbour in neighbours){
        if (!_visitedRooms.contains(neighbour)){
          allNeighboursVisited = false;
          _wallRemover(currentRoom, neighbour);
          currentRoom = neighbour;
          _stack.add(currentRoom);
          _visitedRooms.add(currentRoom);
          break;
        }
      }
      if (allNeighboursVisited){
        currentRoom = _stack.removeLast();
      }
    }
  }

  bool _doesWallExistBetween(int slot, Direction direction) {
    try {
      switch (direction) {
        case Direction.up:
          return _board[slot - 7] == Constants.boardWall;
        case Direction.down:
          return _board[slot + 7] == Constants.boardWall;
        case Direction.left:
          if (slot%7!=0){
            return _board[slot - 1] == Constants.boardWall;
          } else {
            return false;
          }
        case Direction.right:
          if (![6,20,34,48].contains(slot)){
            return _board[slot + 1] == Constants.boardWall;
          } else {
            return false;
          }
      }
    } catch (e) {
      return false;
    }
  }

  void _wallRemover(int from, int to){
      if (wallSituation.containsKey('$from,$to')){
        wallSituation['$from,$to'] = false;
      } else if  (wallSituation.containsKey('$to,$from')){
        wallSituation['$to,$from'] = false;
      }
  }

  void _wallCleaner(){
    int blockedWalls = 0;
    wallSituation.forEach((key, value) {
      if (value) {
        blockedWalls++;
      }
    });
    while (blockedWalls > _totalWallsAvailable){
      int random = Random().nextInt(wallSituation.length);
      if (wallSituation.values.elementAt(random)){
        wallSituation[wallSituation.keys.elementAt(random)] = false;
        blockedWalls--;
      }
    }
  }


  void _setToBoard(){
    wallSituation.forEach((key, value) {
      _board[wallTo49Map[key]!] = value ? Constants.boardWall : Constants.boardEmpty;
    });
    int i = 0;
    for (var element in _canBeTiles) {
      _board[element] = tiles[i];
      i++;
    }
  }

  bool _foundInSlot(String tile, List<int> slots) {
    for (int slot in slots) {
      if (tiles.indexOf(tile) == slot){
        return true;
      }
    }
    return false;
  }

  bool _hasDirectAccess(String tile1, String tile2) {
    int slot1 = tiles.indexOf(tile1);
    int slot2 = tiles.indexOf(tile2);
    if (slotsWithDirectAccess[slot1]!.contains(slot2)) {
      return true;
    }
    return false;
  }

  void _securityWallRemover(){
    int slot1 = tiles.indexOf(Constants.boardTileSecurityRoom);
    int slot2 = tiles.indexOf(Constants.boardTileVault);
    _wallRemover(slot1, slot2);
  }

  Widget boardDesigner(int row, int col, String tileName){
    if (tileName == Constants.boardWall){
      if (row%2 == 1){
        return Container(
          width: 85,
          height: 5,
          color: Colors.yellow,
        );
      } else {
        return Container(
          width: 5,
          height: 85,
          color: Colors.yellow,
        );
      }
    } else if (tileName == Constants.boardEmpty){
      if (row%2 == 1){
        if (col%2 == 1){
          return Container(
            width: 5,
            height: 5,
            color: Colors.grey.shade500,
          );
        } else {
          return Container(
            width: 85,
            height: 5,
            color: Colors.grey.shade500,
          );
        }
      } else {
        return Container(
          width: 5,
          height: 85,
          color: Colors.grey.shade500,
        );
      }
    } else {
      return GestureDetector(
        onTap: (){
          _flutterTts?.stop();
          Future.delayed(const Duration(seconds: 1), (){
            _speak(row*7+col,row~/2*4+col~/2, tileName);
          });
        },
        child: Container(
          width: 85,
          height: 85,
          color: Colors.green.shade900,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                tileName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  Future readBoard() async{
    if (_isTalking == true){
      _isTalking = false;
      await _flutterTts?.stop();
    } else {
      for (int i = 0; i < 7; i++) {
        for (int j = 0; j < 7; j++) {
          if (_board[i * 7 + j] != Constants.boardWall &&
              _board[i * 7 + j] != Constants.boardEmpty) {
            if (_cancelReading){
              _cancelReading = false;
              return;
            }
            await _speak(i * 7 + j, i ~/ 2 * 4 + j ~/ 2, _board[i * 7 + j]);
            await Future.delayed(Duration(seconds: _pauseSeconds), () {});
          }
        }
      }
    }
  }

  void readAloud(BuildContext context) async{
    showDialog(
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (context, setState){
                return AlertDialog(
                  title: const Text('Reading configuration'),
                  content:  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Choose your desired configuration for the reader.'),
                      const Text('Speech speed', style: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.bold,), textAlign: TextAlign.center),
                      Slider(value: _speechRate.toDouble(),
                        max: 7,
                        min: 1,
                        divisions: 7,
                        onChanged: (newValue){
                          speechRate = newValue.toInt();
                          notifyListeners();
                          setState((){});
                        },
                        label: _speechRate.toString(),
                      ),
                      const Text('Pause between phrases (seconds)', style: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      Slider(value: _pauseSeconds.toDouble(),
                        max: 10,
                        min: 1,
                        divisions: 10,
                        onChanged: (newValue){
                          _pauseSeconds = newValue.toInt();
                          notifyListeners();
                          setState((){});
                        },
                        label: _pauseSeconds.toString(),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          _stopReading();
                        },
                        child: const Text('Cancel', style: TextStyle(color: Colors.red, fontSize: 14))
                    ),
                    TextButton(
                      onPressed: () async {
                        readBoard();
                      },
                      child: const Text('Read aloud', style: TextStyle(fontSize: 14)),
                    ),
                  ],
                );
              }
          );
        }
    ).then((value) => _stopReading());
  }

  Future<void> _speak(int slot49, int slot16, String tile) async {
    bool wallUp = _doesWallExistBetween(slot49, Direction.up);
    bool wallDown = _doesWallExistBetween(slot49, Direction.down);
    bool wallLeft = _doesWallExistBetween(slot49, Direction.left);
    bool wallRight = _doesWallExistBetween(slot49, Direction.right);
    String text = 'slot ${slot16+1}: ${tile != Constants.boardTileITRoom ? tile : 'I T Room'}.';
    if (wallUp || wallRight || wallLeft || wallDown){
      text += ' There are walls in the following places: ';
      if (wallUp){
        text += 'up; ';
      }
      if (wallRight){
        text += 'right; ';
      }
      if (wallLeft){
        text += 'left; ';
      }
      if (wallDown){
        text += 'down. ';
      }
    } else {
      text += ' No walls.';
    }
    _isTalking = true;
    _flutterTts?.setSpeechRate(_speechRate / 10);
    await _flutterTts?.speak(text);
    _isTalking = false;
  }

  _stopReading(){
    _flutterTts?.stop();
    _cancelReading = true;
    notifyListeners();
  }
}
