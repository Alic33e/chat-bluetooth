import 'dart:async';
import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothController {
 BluetoothDevice? _device;
 BluetoothCharacteristic? _selectedCharacteristic;
 StreamSubscription<List<int>>? _valueChangedSubscription;

 Future<void> connectToDevice(BluetoothDevice device) async {
    _device = device;
    await _device!.connect();
    List<BluetoothService> services = await _device!.discoverServices();
    for (BluetoothService service in services) {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.properties.write) {
          _selectedCharacteristic = characteristic;
          break;
        }
      }
    }
    await startListening();
 }

 Future<void> startListening() async {
    if (_selectedCharacteristic != null) {
      _valueChangedSubscription = _selectedCharacteristic!.value.listen((data) {
        String message = utf8.decode(data);
        print("Mensaje recibido: $message");
        // Aquí deberías actualizar la UI con el mensaje recibido
        // Esto puede requerir pasar el mensaje a la UI a través de un callback o un Stream
      });
      await _selectedCharacteristic!.setNotifyValue(true);
    }
 }

 Future<void> sendMessage(String message) async {
    if (_selectedCharacteristic != null) {
      List<int> bytes = utf8.encode(message);
      await _selectedCharacteristic!.write(bytes, withoutResponse: false);
      print("Mensaje enviado: $message");
    } else {
      print("No se seleccionó ninguna característica para enviar mensajes");
    }
 }

 void dispose() {
    _valueChangedSubscription?.cancel();
    _device?.disconnect();
 }
}
