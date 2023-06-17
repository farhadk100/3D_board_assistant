import 'package:board_assistant/utils/consts.dart';
import 'package:flutter/cupertino.dart';

class BoardBase extends ChangeNotifier{
  final List<String> tiles = [
    Constants.boardTileEntrance,
    Constants.boardTileArmory,
    Constants.boardTileCopyRoom,
    Constants.boardTileVault,
    Constants.boardTileMeetingRoom,
    Constants.boardTileManagerOffice,
    Constants.boardTileReception,
    Constants.boardTileRestRoom,
    Constants.boardTileSecurityRoom,
    Constants.boardTileFirstAidRoom,
    Constants.boardTileGarden,
    Constants.boardTileITRoom,
    Constants.boardTileKitchen,
    Constants.boardTileLobby,
    Constants.boardTileLogistics,
    Constants.boardTileRooftop,
  ];

  List<String> getGuardableTiles() {
    List<String> guardableTiles = [];
    for (var element in tiles) {
      if (element != Constants.boardTileEntrance && element != Constants.boardTileRooftop && element != Constants.boardTileGarden && element != Constants.boardTileVault && element != Constants.boardTileSecurityRoom) {
        guardableTiles.add(element);
      }
    }
    return guardableTiles;
  }


  final Map<int, List<int>> slotsWithDirectAccess = {
    0: [1, 4],
    1: [0, 2, 5],
    2: [1, 3, 6],
    3: [2, 7],
    4: [0, 5, 8],
    5: [1, 4, 6, 9],
    6: [2, 5, 7, 10],
    7: [3, 6, 11],
    8: [4, 9, 12],
    9: [5, 8, 10, 13],
    10: [6, 9, 11, 14],
    11: [7, 10, 15],
    12: [8, 13],
    13: [9, 12, 14],
    14: [10, 13, 15],
    15: [11, 14],
  };

  final Map<String, bool> wallSituation = {
    '0,1': true,
    '0,4': true,
    '1,2': true,
    '1,5': true,
    '2,3': true,
    '2,6': true,
    '3,7': true,
    '4,5': true,
    '4,8': true,
    '5,6': true,
    '5,9': true,
    '6,7': true,
    '6,10': true,
    '7,11': true,
    '8,9': true,
    '8,12': true,
    '9,10': true,
    '9,13': true,
    '10,11': true,
    '10,14': true,
    '11,15': true,
    '12,13': true,
    '13,14': true,
    '14,15': true,
  };

  final Map<String, int> wallTo49Map = {
    '0,1': 1,
    '0,4': 7,
    '1,2': 3,
    '1,5': 9,
    '2,3': 5,
    '2,6': 11,
    '3,7': 13,
    '4,5': 15,
    '4,8': 21,
    '5,6': 17,
    '5,9': 23,
    '6,7': 19,
    '6,10': 25,
    '7,11': 27,
    '8,9': 29,
    '8,12': 35,
    '9,10': 31,
    '9,13': 37,
    '10,11': 33,
    '10,14': 39,
    '11,15': 41,
    '12,13': 43,
    '13,14': 45,
    '14,15': 47,
  };
}