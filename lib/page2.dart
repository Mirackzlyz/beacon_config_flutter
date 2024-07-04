import 'dart:convert';

import 'custom_drawer.dart' show CustomDrawer;
import 'package:flutter/material.dart';
//import http package
import 'package:http/http.dart' as http;
// Define your DeviceInfo class here (same as before)
class DeviceInfo {
  String rssi;
  String deviceName;
  String macAddress;
  String approxDistance;
  String advertisementData;
  bool isSelected;

  DeviceInfo({
    required this.rssi,
    required this.deviceName,
    required this.macAddress,
    required this.approxDistance,
    required this.advertisementData,
    this.isSelected = false,
  });
}

Future<List<DeviceInfo>> fetchData() async {
  try {
    final response = await http.get(Uri.parse('http://10.34.82.169/getDevices'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<DeviceInfo> devices = [];

      // Assuming your JSON response is an array of device information
      List<dynamic> jsonResponse = json.decode(response.body);

      devices = jsonResponse.map((data) => DeviceInfo(
        rssi: data['rssi'],
        deviceName: data['deviceName'],
        macAddress: data['macAddress'],
        approxDistance: data['approxDistance'],
        advertisementData: data['advertisementData'],
        isSelected: false, // Default value for isSelected
      )).toList();

      return devices;
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any other exceptions that might occur
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
        rssi: '-50',
        deviceName: 'Device 1',
        macAddress: '00:11:22:33:44:55',
        approxDistance: '1m',
        advertisementData: 'Data 1',
        isSelected: false,
      ),
      DeviceInfo(
        rssi: '-60',
        deviceName: 'Device 2',
        macAddress: '66:77:88:99:AA:BB',
        approxDistance: '2m',
        advertisementData: 'Data 2',
        isSelected: false,
      ),
      DeviceInfo(
        rssi: '-70',
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
