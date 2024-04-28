import 'package:flutter/material.dart';
import 'package:myapp2/controllers/bluetooth_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BluetoothController bluetoothController = BluetoothController();

  @override
  void initState() {
    super.initState();
    bluetoothController.getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dispositivos Bluetooth'),
      ),
      body: ListView.builder(
        itemCount: bluetoothController.devicesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(bluetoothController.devicesList[index].name),
            subtitle: Text(bluetoothController.devicesList[index].id.toString()),
          );
        },
      ),
    );
  }
}
