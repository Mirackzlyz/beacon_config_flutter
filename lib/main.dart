import 'package:flutter/material.dart';
import 'page1.dart'; // Ensure this file defines a Page1 class
import 'page2.dart'; // Ensure this file defines a Page2 class

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Beacon Config and Monitor App'),
    );
  }
}

//define a custom drawer to used in all pages
class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Navigation Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.one_k),
            title: Text('Page 1'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Page1()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.two_k),
            title: Text('Page 2'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Page2()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text('Main Page'),
      ),
    );
  }
}



class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String dropdownValue = 'One';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller1,
                    decoration: InputDecoration(
                      hintText: 'Enter Mac adress to be added to the list',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle the button press
                  },
                  child: Text('Enter RSSI Limit'),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller2,
                    decoration: InputDecoration(
                      hintText: 'Enter something else',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle the button press
                  },
                  child: Text('Button 2'),
                ),
              ],
            ),
            Container(
              width: 300, // Set your desired width here
              child: DropdownButton<String>(
                isExpanded: true, // This ensures the dropdown button fills the container
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['One', 'Two', 'Three', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle the first button press
                  },
                  child: Text('Spinner Button 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle the second button press
                  },
                  child: Text('Spinner Button 2'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
