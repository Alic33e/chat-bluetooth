import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';

class BluetoothOffScreen extends StatefulWidget {
 @override
 _BluetoothOffScreenState createState() => _BluetoothOffScreenState();
}

class _BluetoothOffScreenState extends State<BluetoothOffScreen> {
 @override
 void initState() {
    super.initState();
    checkBluetoothAndPermissions();
 }

 Future<void> checkBluetoothAndPermissions() async {
    if (await FlutterBluePlus.isAvailable == false) {
      print("Bluetooth no soportado por este dispositivo");
      return;
    }

    var bluetoothConnectStatus = await Permission.bluetoothConnect.request().isGranted;
    var bluetoothScanStatus = await Permission.bluetoothScan.request().isGranted;

    if (bluetoothConnectStatus && bluetoothScanStatus) {
      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Permisos necesarios'),
            content: Text('Esta aplicación necesita permisos para usar Bluetooth.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                 Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
 }

 Future<void> enableBluetooth() async {
    String result = await BluetoothEnable.enableBluetooth;
    bool isBluetoothEnabled = result == "true"; // Convierte el String a bool
    if (isBluetoothEnabled) {
      Navigator.of(context).pop();
    } else {
      // Manejar el caso en que el usuario no activa el Bluetooth
      // Por ejemplo, mostrar un mensaje o un diálogo
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Bluetooth no activado'),
            content: Text('Por favor, activa el Bluetooth para continuar.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                 Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Desactivado'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'El Bluetooth está desactivado. Por favor, actívalo.',
            ),
            ElevatedButton(
              onPressed: enableBluetooth,
              child: Text('Activar Bluetooth'),
            ),
          ],
        ),
      ),
    );
 }
}
