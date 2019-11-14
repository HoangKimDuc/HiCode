import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

class Scanner extends StatefulWidget {
  Scanner({this.controller, this.onInit});
  final QRViewController controller;
  final Function(QRViewController) onInit;
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner>
    with AutomaticKeepAliveClientMixin<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  ValueNotifier<bool> rearCamera = ValueNotifier<bool>(true);
  ValueNotifier<bool> flashOn = ValueNotifier<bool>(false);

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        QRView(
          key: qrKey,
          onQRViewCreated: widget.onInit,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.white,
            borderRadius: 4,
            borderLength: 20,
            borderWidth: 5,
            cutOutSize: 300,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: ValueListenableBuilder(
                valueListenable: rearCamera,
                builder: (_, rearCameraValue, child) {
                  return Icon(
                      rearCameraValue ? Icons.camera_rear : Icons.camera_front);
                },
              ),
              onPressed: () {
                widget.controller.flipCamera();
                rearCamera.value = !rearCamera.value;
              },
            ),
            const SizedBox(
              width: 20,
            ),
            IconButton(
              icon: ValueListenableBuilder(
                valueListenable: flashOn,
                builder: (_, flashOnValue, child) {
                  return Icon(flashOnValue ? Icons.flash_on : Icons.flash_off);
                },
              ),
              onPressed: () {
                widget.controller.toggleFlash();
                flashOn.value = !flashOn.value;
              },
            )
          ],
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
