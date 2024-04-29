import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:myapp2/pages/chat_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    FlutterBluePlus.adapterState
        .listen((state) => setState(() => _adapterState = state));
  }

  Future<void> _startScan() async {
    if (!_isScanning) {
      setState(() => _isScanning = true);
      _scanResults = [];
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
      FlutterBluePlus.scanResults
          .listen((results) => setState(() => _scanResults = results));
    }
  }

  Future<void> _stopScan() async {
    if (_isScanning) {
      setState(() => _isScanning = false);
      await FlutterBluePlus.stopScan();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bluetooth App')),
      body: Column(
        children: [
          Text('Bluetooth Adapter State: $_adapterState'),
          ElevatedButton(
            onPressed: _isScanning ? _stopScan : _startScan,
            child: Text(_isScanning ? 'Stop Scan' : 'Start Scan'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _scanResults.length,
              itemBuilder: (context, index) {
                final result = _scanResults[index];
                return ListTile(
                  title: Text(
                      result.device.platformName.isEmpty ? 'Dispositivo desconocido' : result.device.platformName),
                  subtitle: Text('RSSI: ${result.rssi}'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChatScreen(device: result.device)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
