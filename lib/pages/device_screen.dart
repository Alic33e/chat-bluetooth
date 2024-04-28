import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class DeviceScreen extends StatelessWidget {
 final BluetoothDevice device;

 DeviceScreen({required this.device});

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name ?? 'Device Details'),
      ),
      body: Center(
        child: Text('Device Name: ${device.name}'),
      ),
    );
 }
}
