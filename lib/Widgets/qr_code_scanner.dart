import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:this_is_tayrd/Widgets/custom_button.dart';
import 'package:this_is_tayrd/Widgets/screen_photo.dart';
import 'package:this_is_tayrd/helper/constans.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key});

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> with WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  bool _isValidInteger(String? code) {
    if (code == null) return false;
    final trimmedCode = code.trim();
    return int.tryParse(trimmedCode) != null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera().then((_) {
        controller?.resumeCamera();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مسح رمز العداد الكهربائي',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: kColorPrimer,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: kColorPrimer.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: kColorPrimer,
                    borderRadius: 8,
                    borderLength: 25,
                    borderWidth: 6,
                    cutOutSize: MediaQuery.of(context).size.width * 0.75,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: result != null
                    ? (_isValidInteger(result!.code)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'تم المسح بنجاح!',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: kColorPrimer,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'رقم العداد: ${result!.code!.trim()}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Custombutton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>   AdvancedMeterReader(qrCode: int.parse(result!.code!.trim()),)));
                                  },
                                  lable: "متابعة",
                                ),
                              )
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'رمز غير صحيح!',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'يجب أن يحتوي الرمز على أرقام فقط',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Custombutton(
                                  onPressed: () {
                                    setState(() {
                                      result = null;
                                    });
                                    controller?.resumeCamera();
                                  },
                                  lable: "إعادة المحاولة",
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.assignment_ind_outlined,
                              size: 50, color: kColorPrimer),
                          const SizedBox(height: 20),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                height: 1.5,
                              ),
                              children: const [
                                TextSpan(
                                  text:
                                      'توجيه الكاميرا نحو رمز العداد الكهربائي\n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kColorPrimer,
                                    fontSize: 20,
                                  ),
                                ),
                                TextSpan(
                                    text:
                                        'تأكد من أن الرمز يحتوي على أرقام فقط\n'),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null && result == null) {
        setState(() {
          result = scanData;
        });
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }
}