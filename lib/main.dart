import 'package:board_assistant/ui/boardrandomizerpage.dart';
import 'package:board_assistant/ui/guardrandomizerpage.dart';
import 'package:board_assistant/ui/homepage.dart';
import 'package:board_assistant/ui/qrcodepage.dart';
import 'package:board_assistant/ui/service/boardrandomizerservice.dart';
import 'package:board_assistant/ui/service/guardrandomizerservice.dart';
import 'package:board_assistant/ui/service/homepageservice.dart';
import 'package:board_assistant/ui/service/qrcodeservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() {
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey.shade300
      ),
      routes: {
        '/': (context) => ChangeNotifierProvider<HomePageService>(create: (context) => HomePageService(), child: const HomePage()),
        'boardRandomizer': (context) => ChangeNotifierProvider<BoardRandomizerService>(create: (context) => BoardRandomizerService(), child: const BoardRandomizerPage()),
        'guardRandomizer': (context) => ChangeNotifierProvider<GuardRandomizerService>(create: (context) => GuardRandomizerService(), child: const GuardRandomizerPage()),
        'qrCode': (context) => ChangeNotifierProvider<QrCodeService>(create: (context) => QrCodeService(), child: const QrCodePage()),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
