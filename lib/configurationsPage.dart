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
  List<String> selectableItems = []; // Initialize as an empty growable list
  List<bool> selectedItemStatus = []; // Initialize as an empty growable list

  @override
  void initState() {
    super.initState();
    // Initialize selectedItemStatus with the correct length
    selectedItemStatus = List<bool>.filled(selectableItems.length, false, growable: true);
  }

  void addItem(String item) {
    setState(() {
      selectableItems.add(item);
      selectedItemStatus.add(false); // Ensure selectedItemStatus is updated accordingly

    });
  }

  void removeItem(int index) {
    setState(() {
      if (index >= 0 && index < selectableItems.length) {
        selectableItems.removeAt(index);
        selectedItemStatus.removeAt(index); // Ensure selectedItemStatus is updated accordingly
      }
    });
  }
  void clearList() {
    setState(() {
      selectableItems.clear();
      selectedItemStatus.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurations Page'),
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // Color of the border
                  width: 2.0, // Width of the border
                ),
              ),
              child: ListView.builder(
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
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isWhitelistMode = !isWhitelistMode;
                          });
                        },
                        child: Text(isWhitelistMode ? 'Whitelist Mode' : 'Blacklist Mode'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle the button press
                           clearList();

                        },
                        child: Text('Clear List'),
                      )
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
                          addItem(_controller1.text);

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
