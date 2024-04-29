import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:myapp2/pages/bluetooth_off_screen.dart';
import 'package:myapp2/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<BluetoothAdapterState>(
        stream: FlutterBluePlus.adapterState,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == BluetoothAdapterState.on) {
              return BluetoothOffScreen();
            } else {
              // Muestra una pantalla de instrucciones o un mensaje de error cuando el Bluetooth está desactivado
              return BluetoothOffScreen();
            }
          } else {
            // Muestra una pantalla de carga mientras se verifica el estado del Bluetooth
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
