import 'package:board_assistant/ui/service/qrcodeservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodePage extends StatelessWidget {
  const QrCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QrCodeService>(
        builder: (context, model, child){
          return Scaffold(
              appBar: AppBar(
                title: const Text('QR Reader'),
              ),
            body: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                  child: QRView(key: model.qrKey, onQRViewCreated: model.onQRViewCreated, formatsAllowed: const [BarcodeFormat.qrcode],)
              ),
            )
          );
        }
    );
  }
}
