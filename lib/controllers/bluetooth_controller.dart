import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothController {
 StreamSubscription<BluetoothConnectionState>? _connectionStateSubscription;

 Future<void> connectToDevice(BluetoothDevice device) async {
    // Cancelar cualquier suscripción existente para evitar duplicados
    _connectionStateSubscription?.cancel();

    // Suscribirse al estado de conexión del dispositivo
    _connectionStateSubscription = device.connectionState.listen((state) {
      print('Connection State: $state');
      // Aquí puedes manejar el estado de conexión
    });

    // Conectar al dispositivo
    await device.connect();
 }

 Future<void> disconnectFromDevice(BluetoothDevice device) async {
    // Desconectar del dispositivo
    await device.disconnect();

    // Cancelar la suscripción al estado de conexión
    _connectionStateSubscription?.cancel();
 }

 void dispose() {
    _connectionStateSubscription?.cancel();
 }
}
