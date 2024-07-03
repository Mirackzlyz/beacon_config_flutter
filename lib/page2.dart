import 'package:flutter/material.dart';
import 'custom_drawer.dart';

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
      subtitle: Text('MAC: ${widget.deviceInfo.macAddress}, RSSI: ${widget.deviceInfo.rssi}, Distance: ${widget.deviceInfo.approxDistance}, ADV: ${widget.deviceInfo.advertisementData}'),
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
  List<DeviceInfo> devices = []; // Populate this list with actual device data


  @override
  void initState() {
    super.initState();
    _populateDevices();
  }

  void _populateDevices() {
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
                        devices[index].isSelected = value!;
                      });
                    },
                  );
                },
              ),
            ),
            Row(
              //add 5 buttons
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle the first button press
                  },
                  child: Text('Button 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle the second button press
                  },
                  child: Text('Button 2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle the third button press
                  },
                  child: Text('Button 3'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle the fourth button press
                  },
                  child: Text('Button 4'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle the fifth button press
                  },
                  child: Text('Button 5'),
                ),
              ],
            )

          ]
      ),



    );
  }
}
