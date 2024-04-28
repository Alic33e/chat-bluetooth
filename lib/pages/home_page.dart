import 'package:flutter/material.dart';
import 'package:myapp2/controllers/bluetooth_controller.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

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

 Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect(); // Utiliza el método correcto para conectar
      // Aquí puedes manejar la conexión exitosa, por ejemplo, mostrando un Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Conectado a ${device.name}')),
      );
    } catch (e) {
      // Manejar errores de conexión
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al conectar: $e')),
      );
    }
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
          BluetoothDevice device = bluetoothController.devicesList[index];
          return ListTile(
            title: Text(device.name),
            subtitle: Text(device.id.toString()),
            trailing: IconButton(
              icon: Icon(Icons.bluetooth_connected),
              onPressed: () => connectToDevice(device),
            ),
          );
        },
      ),
    );
 }
}
