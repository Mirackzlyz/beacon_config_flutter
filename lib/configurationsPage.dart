import 'package:flutter/material.dart';
import 'custom_drawer.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  _Page1State createState() => _Page1State();
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


class _Page1State extends State<Page1> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String dropdownValue = 'One';
  bool isWhitelistMode = false;
  List<String> selectableItems = [
    'Item 1',
    'Item 2',
    'Item 3'
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
    'Item 11',
    'Item 12',
    'Item 13',
    'Item 14',
    'Item 15',
    'Item 16',
    'Item 17',
    'Item 18',
    'Item 19',
    'Item 20',

  ]; // Step 1: Define the list of items
  List<bool> selectedItemStatus = [
    false,
    false,
    false
  ]; // Tracks which items are selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurations Page'),
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // Color of the border
                width: 2.0, // Width of the border
              ),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              // Set to true to avoid overflow
              physics: AlwaysScrollableScrollPhysics(),
              // Always enable scrolling
              itemCount: selectableItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectableItems[index]),
                  leading: Checkbox(
                    value: selectedItemStatus[index],
                    onChanged: (bool? value) {
                      setState(() {
                        selectedItemStatus[index] = value!;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      selectedItemStatus[index] = !selectedItemStatus[index];
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            // Adjust flex to control the space taken by the list and the rest of the content
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Existing widgets
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isWhitelistMode = !isWhitelistMode;
                          });
                        },
                        child: Text(isWhitelistMode
                            ? 'Whitelist Mode'
                            : 'Blacklist Mode'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller1,
                          decoration: const InputDecoration(
                            hintText: 'Enter Mac address to be added to the list',
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle the button press
                        },
                        child: const Text('Add Mac to List'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _controller2,
                          decoration: const InputDecoration(
                            hintText: 'Enter rssi threshold value',
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle the button press
                        },
                        child: const Text('Set RSSI Threshold'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle the first button press
                        },
                        child: const Text('Get the current configurations'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle the second button press
                    },
                    child: const Text('Upload Configurations'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
