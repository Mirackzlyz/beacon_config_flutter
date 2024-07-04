import 'dart:convert';

import 'custom_drawer.dart' show CustomDrawer;
import 'package:flutter/material.dart';
//import http package
import 'package:http/http.dart' as http;
// Define your DeviceInfo class here (same as before)
class DeviceInfo {
  int? rssi; // Making it nullable if RSSI can be null
  String deviceName;
  String? macAddress; // Making it nullable if MAC address can be null
  String? approxDistance; // Making it nullable if approxDistance can be null
  String? advertisementData; // Making it nullable if advertisementData can be null
  bool isSelected;

  DeviceInfo({
    this.rssi, // Allow it to be null
    required this.deviceName, // Assuming deviceName is always provided
    this.macAddress, // Allow it to be null
    this.approxDistance, // Allow it to be null
    this.advertisementData, // Allow it to be null
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
  // This regex matches all control characters and non-printable characters except whitespace (space, tab)
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
        rssi: data['rssi'] ?? -999, // Ensure this is an int in your JSON
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


// Define your DeviceInfoWidget class here (same as before)
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

    return ListTile(
      title: Text(widget.deviceInfo.deviceName),
      subtitle: Text(
          'MAC: ${widget.deviceInfo.macAddress}, RSSI: ${widget.deviceInfo.rssi}, Distance: ${widget.deviceInfo.approxDistance}, ADV: ${widget.deviceInfo.advertisementData}'),
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
  List<DeviceInfo> devices = []; // Placeholder for devices list

  @override
  void initState() {
    super.initState();
    _populateDevices(); // Initially populate with placeholder data
  }

  void _populateDevices() {
    // Placeholder data - replace with actual data fetching logic
    devices = [
      DeviceInfo(
        rssi: 50,
        deviceName: 'Device 1',
        macAddress: '00:11:22:33:44:55',
        approxDistance: '1m',
        advertisementData: 'Data 1',
        isSelected: false,
      ),
      DeviceInfo(
        rssi: 60,
        deviceName: 'Device 2',
        macAddress: '66:77:88:99:AA:BB',
        approxDistance: '2m',
        advertisementData: 'Data 2',
        isSelected: false,
      ),
      DeviceInfo(
        rssi: 70,
        deviceName: 'Device 3',
        macAddress: 'CC:DD:EE:FF:00:11',
        approxDistance: '3m',
        advertisementData: 'Data 3',
        isSelected: false,
      ),
    ];
  }

  void fetchDataAndUpdateDevices() async {
    try {
      List<DeviceInfo> fetchedDevices = await fetchData();
      setState(() {
        devices = fetchedDevices;
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error (e.g., show a snackbar)
    }
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {
                  //fetch data from the server
                  fetchDataAndUpdateDevices();

                },
                child: Text('Fetch Data'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: Text('Copy MAC Addresses'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: Text('Add to Favorites'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: Text('Button 4'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: Text('Button 5'),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
