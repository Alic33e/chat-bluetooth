import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:intl/intl.dart'; // Agrega esta línea para usar la librería de formato de fecha

class ChatScreen extends StatefulWidget {
  final BluetoothDevice device;

  ChatScreen({required this.device});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _messages = []; // Cambia a una lista de mapas
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
                final message = _messages[index];
                final isOwnMessage = message['sender'] == 'Tú';
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Align(
                    alignment: isOwnMessage ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment:
                          isOwnMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: isOwnMessage ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Text(
                            message['text'],
                            style: TextStyle(
                              color: isOwnMessage ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          DateFormat('HH:mm').format(message['timestamp']),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
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
                        _messages.add({
                          'text': message,
                          'sender': 'Tú',
                          'timestamp': DateTime.now(),
                        });
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