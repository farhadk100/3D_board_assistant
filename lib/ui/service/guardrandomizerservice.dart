import 'dart:math';

import 'package:board_assistant/ui/service/boardbase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class GuardRandomizerService extends BoardBase{

  FlutterTts _flutterTts = FlutterTts();
  int _speechRate = 4;
  int _pauseSeconds = 5;
  bool _cancelReading = false;

  int _guardCount = 15;
  int get guardCount => _guardCount;
  set guardCount(int value) {
    _guardCount = value;
    notifyListeners();
  }

  int _keyCount = 2;
  int get keyCount => _keyCount;
  set keyCount(int value) {
    _keyCount = value;
    notifyListeners();
  }

  final Map<String, int> _guardPositions = {};
  final List<String> _keyPositions = [];
  Map<String, int> get guardPositions => _guardPositions;

  GuardRandomizerService(){
    generateGuards();
  }

  @override
  void dispose() {
    _flutterTts.awaitSpeakCompletion(false);
    _flutterTts.stop();
    super.dispose();
  }

  void generateGuards(){
    _guardPositions.clear();
    _keyPositions.clear();
    List<String> guardableTiles = getGuardableTiles();
    for(int i = 0; i < _guardCount; i++){
      bool goToNext = false;
      String room = getGuardableTiles()[Random().nextInt(guardableTiles.length)];
      while(!goToNext){
        if(_guardPositions.containsKey(room)){
          if (_guardPositions[room]! <= 4){
            _guardPositions[room] = _guardPositions[room]! + 1;
            goToNext = true;
          }
        } else {
          _guardPositions[room] = 1;
          goToNext = true;
        }
        room = getGuardableTiles()[Random().nextInt(guardableTiles.length)];
      }
    }
    for (int i = 0; i< _keyCount; i++){
      bool goToNext = false;
      String room = '';
      while (room.isEmpty){
        String randomRoom = getGuardableTiles()[Random().nextInt(guardableTiles.length)];
        if (_guardPositions.containsKey(randomRoom)){
          room = randomRoom;
        }
      }
      _keyPositions.add(room);
    }
    print(_keyPositions);
    notifyListeners();
  }

  String getGuardPositionKey(int index){
    return _guardPositions.keys.elementAt(index);
  }

  int getKeyCount(String room){
    return _keyPositions.where((element) => element == room).length;
  }

  readAloud(BuildContext context) async {
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
                      _speechRate = newValue.toInt();
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
                    stopReading();
                  },
                  child: const Text('Cancel', style: TextStyle(color: Colors.red, fontSize: 14))
                ),
                TextButton(
                  onPressed: () async {
                    for (String room in _guardPositions.keys){
                      if (_cancelReading){
                        _cancelReading = false;
                        return;
                      }
                      String whatToSay = '$room has ${_guardPositions[room]} guard${_guardPositions[room]! > 1 ? 's' : ''}'
                          + ' ${getKeyCount(room) > 0 ? '(${getKeyCount(room)} guard${getKeyCount(room) > 1 ? 's' : ''} ha${getKeyCount(room) > 1 ? 've' : 's'} key)' : ''}';
                      if (whatToSay.contains('IT Room')){
                        whatToSay = whatToSay.replaceAll('IT Room', 'IT Room');
                      }
                      _flutterTts.setSpeechRate(_speechRate.toDouble() / 10);
                      await _flutterTts.speak(whatToSay);
                      await Future.delayed(Duration(seconds: _pauseSeconds));
                    }
                  },
                  child: const Text('Read aloud', style: TextStyle(fontSize: 14)),
                ),
              ],
            );
          }
        );
      }
    ).then((value) => stopReading());
  }

  stopReading(){
    _flutterTts.stop();
    _cancelReading = true;
    notifyListeners();
  }
}