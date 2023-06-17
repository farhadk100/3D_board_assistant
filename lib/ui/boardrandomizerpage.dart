import 'package:board_assistant/ui/service/boardrandomizerservice.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class BoardRandomizerPage extends StatelessWidget {
  const BoardRandomizerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardRandomizerService>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Board Randomizer'),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade500,
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text('Maximum wall count', style: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.bold),),
                      Slider(value: model.totalWallsAvailable.toDouble(),
                        max: 9,
                        min: 4,
                        divisions: 5,
                        onChanged: (newValue){
                          model.totalWallsAvailable = newValue.toInt();
                        },
                        label: model.totalWallsAvailable.toString(),
                      ),
                      const Text('Speech speed', style: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.bold),),
                      Slider(value: model.speechRate.toDouble(),
                          max: 7,
                          min: 1,
                          divisions: 7,
                          onChanged: (newValue){
                            model.speechRate = newValue.toInt();
                          },
                          label: model.speechRate.toString(),
                      )
                    ],
                  ),
                )
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      child: MaterialButton(
                        onPressed: () => model.generateBoard(),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            FaIcon(FontAwesomeIcons.dice, color: Colors.white,),
                            Text('  Randomize',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      child: MaterialButton(
                        onPressed: () => model.readAloud(context),
                        color: Colors.deepPurple,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            FaIcon(FontAwesomeIcons.volumeHigh, color: Colors.white,),
                            Text('  Read Aloud',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(var i = 0; i < 7; i++)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for(var j = 0; j < 7; j++)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.shade700,
                                border: Border.all(
                                  color: Colors.grey.shade500,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                  child: model.boardDesigner(i,j, model.board[i*7+j].toString())
                              ),
                            ),
                        ],
                      )
                  ],
                )
              ),
            ),
          ),
        );
      },
    );
  }
}
