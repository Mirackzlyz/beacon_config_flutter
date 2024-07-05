import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'custom_drawer.dart';

// Define DeviceInfo and Device classes
class DeviceInfo {
  int? rssi;
  String deviceName;
  String? macAddress;
  String? approxDistance;
  String? advertisementData;
  bool isSelected;

  DeviceInfo({
    this.rssi,
    required this.deviceName,
    this.macAddress,
    this.approxDistance,
    this.advertisementData,
    this.isSelected = false,
  });
}

class Device {
  final String mac;
  final int rssi;
  final String? name;
  final String? advData;
  final double distance;

  Device({
    required this.mac,
    required this.rssi,
    required this.name,
    required this.advData,
    required this.distance,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      mac: json['mac'],
      rssi: json['rssi'],
      name: json['name'],
      advData: json['advData'],
      distance: json['distance'].toDouble(),
    );
  }
}

class DevicesResponse {
  final List<Device> devices;

  DevicesResponse({required this.devices});

  factory DevicesResponse.fromJson(Map<String, dynamic> json) {
    var list = json['devices'] as List;
    List<Device> devicesList = list.map((i) => Device.fromJson(i)).toList();
    return DevicesResponse(devices: devicesList);
  }
}

DevicesResponse parseDevicesResponse(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return DevicesResponse.fromJson(parsed);
}

String cleanJsonString(String jsonString) {
  return jsonString.replaceAll(RegExp(r'[\x00-\x1F\x7F-\x9F]'), '');
}

Future<List<DeviceInfo>> fetchData() async {
  try {
    final response = await http.get(Uri.parse('http://10.34.82.169/getDevices'));
    print(response.body);
    if (response.statusCode == 200) {
      String cleanJson = cleanJsonString(response.body);
      Map<String, dynamic> jsonResponse = json.decode(cleanJson);
      List<dynamic> devicesJson = jsonResponse['devices'];

      List<DeviceInfo> devices = devicesJson.map((data) => DeviceInfo(
        rssi: data['rssi'] ?? -999,
        deviceName: data['deviceName'] ?? 'Unknown',
        macAddress: data['macAddress'],
        approxDistance: data['approxDistance'],
        advertisementData: data['advertisementData'],
        isSelected: false,
      )).toList();

      return devices;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load data: $e');
  }
}
class DeviceInfoWidget extends StatefulWidget {
  final DeviceInfo deviceInfo;
  final Function(bool?)? onCheckboxChanged;

  const DeviceInfoWidget({
    Key? key,
    required this.deviceInfo,
    this.onCheckboxChanged,
  }) : super(key: key);

  @override
  _DeviceInfoWidgetState createState() => _DeviceInfoWidgetState();
}

class _DeviceInfoWidgetState extends State<DeviceInfoWidget> {
  @override
  Widget build(BuildContext context) {
    // Corrected Widget build logic
    return ListTile(
      title: Text(widget.deviceInfo.deviceName),
      subtitle: Text(
          'MAC: ${widget.deviceInfo.macAddress ?? 'Unknown'}, RSSI: ${widget.deviceInfo.rssi ?? -999}, Distance: ${widget.deviceInfo.approxDistance ?? 'Unknown'}, ADV: ${widget.deviceInfo.advertisementData ?? 'Unknown'}'),
      trailing: Checkbox(
        value: widget.deviceInfo.isSelected,
        onChanged: widget.onCheckboxChanged,
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<DeviceInfo> devices = [];

  @override
  void initState() {
    super.initState();
    fetchDataAndUpdateDevices();
  }

  void fetchDataAndUpdateDevices() async {
    try {
      List<DeviceInfo> fetchedDevices = await fetchData();
      setState(() {
        devices = fetchedDevices;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Corrected Widget build logic for Page2
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return DeviceInfoWidget(
                  deviceInfo: devices[index],
                  onCheckboxChanged: (bool? value) {
                    setState(() {
                      devices[index].isSelected = value ?? false;
                    });
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: fetchDataAndUpdateDevices,
                child: Text('Fetch Data'),
              ),
              // Additional buttons as needed
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Page2(),
  ));
}
