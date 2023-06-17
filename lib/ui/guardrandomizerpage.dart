import 'package:board_assistant/ui/service/guardrandomizerservice.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class GuardRandomizerPage extends StatelessWidget {
  const GuardRandomizerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GuardRandomizerService>(
      builder: (context, model, child){
        return Scaffold(
          appBar: AppBar(
            title: const Text('Guard Randomizer'),
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
                        const Text('Number of keycards', style: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.bold),),
                        Slider(value: model.keyCount.toDouble(),
                          max: 4,
                          min: 1,
                          divisions: 4,
                          onChanged: (newValue){
                            model.keyCount = newValue.toInt();
                          },
                          label: model.keyCount.toString(),
                        ),
                        const Text('Number of guards', style: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.bold),),
                        Slider(value: model.guardCount.toDouble(),
                          max: 25,
                          min: 10,
                          divisions: 15,
                          onChanged: (newValue){
                            model.guardCount = newValue.toInt();
                          },
                          label: model.guardCount.toString(),
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
                        onPressed: () => model.generateGuards(),
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
            child: model.guardPositions.isNotEmpty ? Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < model.guardPositions.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${model.getGuardPositionKey(i)} has ${model.guardPositions.values.elementAt(i)} guard${model.guardPositions.values.elementAt(i)! > 1 ? 's' : ''}'
                      + ' ${model.getKeyCount(model.getGuardPositionKey(i)) > 0 ? '(${model.getKeyCount(model.getGuardPositionKey(i))} guard(s) have key)' : ''}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ) : const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
