import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hi_code/scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MaterialApp(
    title: 'HiCode',
    theme: ThemeData.dark(),
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QRViewController scanController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: PageView(
        controller: PageController(viewportFraction: 1),
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          if (index == 0) {
            scanController.pauseCamera();
          } else {
            scanController.resumeCamera();
          }
        },
        children: [
          Container(
            alignment: Alignment.center,
            child: Text("A"),
          ),
          Scanner(
            controller: scanController,
            onInit: _onQRViewCreated,
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    print("_onQRViewCreated run");
    setState(() {
      scanController = controller;
    });
    scanController.scannedDataStream.listen((scanData) {
      print(scanData);
      this.onResult(scanData);
    });
  }

  onResult(val) {
    this.scanController.pauseCamera();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 350,
            child: PageView(
              controller: PageController(initialPage: 1),
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text("Dismiss"),
                ),
                Container(
                  child: Text("Code: ${val["text"]}"),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Add"),
                ),
              ],
            ),
          );
        }).then((res) {
      this.scanController.resumeCamera();
    });
  }
}
