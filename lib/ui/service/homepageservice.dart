import 'package:flutter/material.dart';

class HomePageService extends ChangeNotifier{


  openBoardRandomizer(BuildContext context) {
    Navigator.pushNamed(context, 'boardRandomizer');
  }

  openQRReader(BuildContext context) {
    Navigator.pushNamed(context, 'qrReader');
  }

  openGuardRandomizer(BuildContext context) {
    Navigator.pushNamed(context, 'guardRandomizer');
  }

  openQrCode(BuildContext context) {
    Navigator.pushNamed(context, 'qrCode');
  }
}