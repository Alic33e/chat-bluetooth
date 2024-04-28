import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothController {
  List<BluetoothDevice> devicesList = [];

  Future<void> getDevices() async {
    await FlutterBluePlus.startScan(timeout: Duration(seconds: 4));

    FlutterBluePlus.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        if (!devicesList.contains(result.device)) {
          devicesList.add(result.device);
        }
      }
    });

    await FlutterBluePlus.stopScan();
  }
}
