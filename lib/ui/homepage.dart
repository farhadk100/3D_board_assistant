import 'package:board_assistant/ui/service/homepageservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageService>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Board Assistant'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height ? MediaQuery.of(context).size.height / 3 : MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height ? MediaQuery.of(context).size.height / 3 : MediaQuery.of(context).size.width / 2.5,
                        child: ElevatedButton(
                            onPressed: () => model.openQrCode(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text('QR Reader', style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height ? MediaQuery.of(context).size.height / 3 : MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height ? MediaQuery.of(context).size.height / 3 : MediaQuery.of(context).size.width / 2.5,
                        child: ElevatedButton(
                            onPressed: () => model.openBoardRandomizer(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('Board Randomizer', style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height ? MediaQuery.of(context).size.height / 3 : MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height ? MediaQuery.of(context).size.height / 3 : MediaQuery.of(context).size.width / 2.5,
                        child: ElevatedButton(
                            onPressed: () => model.openGuardRandomizer(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                            ),
                            child: const Text('Guard Randomizer', style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height ? MediaQuery.of(context).size.height / 3 : MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width >= MediaQuery.of(context).size.height ? MediaQuery.of(context).size.height / 3 : MediaQuery.of(context).size.width / 2.5,
                        child: ElevatedButton(
                            onPressed: () => SystemNavigator.pop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Exit', style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
