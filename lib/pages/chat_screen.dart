import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class ChatScreen extends StatefulWidget {
  final BluetoothDevice device;

  ChatScreen({required this.device});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> _messages = [];
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat con ${widget.device.name ?? 'Dispositivo'}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Align(
                    alignment: _messages[index].startsWith('Tú:') ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: _messages[index].startsWith('Tú:') ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        _messages[index],
                        style: TextStyle(
                          color: _messages[index].startsWith('Tú:') ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    String message = _textController.text;
                    if (message.isNotEmpty) {
                      sendMessageToDevice(message);
                      setState(() {
                        _messages.add('Tú: $message');
                        _textController.clear();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void sendMessageToDevice(String message) {
    // Aquí debes implementar la lógica para enviar el mensaje al dispositivo Bluetooth
    // Utiliza la API de flutter_blue_plus para interactuar con el dispositivo
    print('Enviando mensaje: $message');
  }
}