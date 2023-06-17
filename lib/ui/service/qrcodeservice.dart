import 'package:board_assistant/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeService extends ChangeNotifier{

  final FlutterTts? _flutterTts = FlutterTts();
  bool _isTalking = false;
  int _speechRate = 4;
  int get speechRate => _speechRate;
  set speechRate(int value) {
    _speechRate = value;
    _flutterTts?.setSpeechRate(_speechRate/10);
    notifyListeners();
  }

  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  GlobalKey get qrKey => _qrKey;

  QRViewController? _qrViewController;
  get qrViewController => _qrViewController;

  Barcode? _result;
  get result => _result;

  @override
  dispose(){
    _flutterTts!.stop();
    _qrViewController?.dispose();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) {
    _qrViewController = controller;
    controller.scannedDataStream.listen((scanData) => _qrFound(scanData));
    _speak('Please Aim the camera at the QR code of the card you want to read. The QR code exists at bottom right corner of the card.');
  }

  void _qrFound(Barcode data){
    if (Constants.cardsText.containsKey(data.code)){
      _qrViewController?.stopCamera();
      readCard(data.code);
      notifyListeners();
    }
  }

  void readCard(String? code) async{
    _speak(Constants.cardsText[code]!);
    showDialog(
        context: qrKey.currentContext!,
        builder: (context){
          return Scaffold(
            backgroundColor: Colors.black26,
            body: Center(
                child: GestureDetector(
                  onTap: () => closeCard(context),
                  child: Image.asset(
                    'assets/images/cards/$code.png',
                    width: MediaQuery.of(context).size.width * (0.9),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
        }
    );
  }

  void closeCard(context){
    Navigator.pop(context);
    _speak('The card is closed. you can scan QR code again!');
    _qrViewController?.resumeCamera();
  }

  void _speak(String phrase){
    _flutterTts?.stop();
    _flutterTts?.speak(phrase);
  }



}