import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Device Names',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BluetoothNamingPage(),
    );
  }
}

class BluetoothNamingPage extends StatefulWidget {
  @override
  _BluetoothNamingPageState createState() => _BluetoothNamingPageState();
}

class _BluetoothNamingPageState extends State<BluetoothNamingPage> {
  late TextEditingController _macController;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _macController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _macController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void saveDeviceName(String macAddress, String deviceName) {
    // Burada MAC adresine isim verme işlemini gerçekleştirebilirsiniz.
    print('MAC Address: $macAddress, Device Name: $deviceName');
    // Örneğin, Firestore veya Realtime Database'e kaydedebilirsiniz.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Device Naming'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _macController,
              decoration: InputDecoration(
                hintText: 'Enter MAC address',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter device name',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String macAddress = _macController.text.trim();
                String deviceName = _nameController.text.trim();
                if (macAddress.isNotEmpty && deviceName.isNotEmpty) {
                  saveDeviceName(macAddress, deviceName);
                  // İsim kaydedildikten sonra yapılacak işlemler
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Device name saved: $deviceName for $macAddress')),
                  );
                  _macController.clear();
                  _nameController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter both MAC address and device name')),
                  );
                }
              },
              child: Text('Save Device Name'),
            ),
          ],
        ),
      ),
    );
  }
}
