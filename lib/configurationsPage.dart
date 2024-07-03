import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'custom_drawer.dart';
import 'dart:convert';


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
  bool isThresholdEnabled = true;
  String rssi = '0';
  List<String> selectableItems = []; // Initialize as an empty growable list
  List<bool> selectedItemStatus = []; // Initialize as an empty growable list
  int scanInterval = 5000; // Default value for scan interval
  int scanDuration = 5000; // Default value for scan duration

  @override
  void initState() {
    super.initState();
    // Initialize selectedItemStatus with the correct length
    selectedItemStatus = List<bool>.filled(selectableItems.length, false, growable: true);
  }

  String buildJson() {
    Map<String, dynamic> data = {
      "macAddresses": selectableItems,
      "tresholdEnabled": isThresholdEnabled,
      "rssiThreshold": int.tryParse(rssi) ?? 0,
      "listMode": isWhitelistMode ? "whitelist" : "blacklist",
      "scanInterval": scanInterval,
      "scanDuration": scanDuration,
    };

    return jsonEncode(data);
  }

  void addItem(String item) {
    //check if item is already in the list
    if (selectableItems.contains(item)) {
      return;
    }
    //check if the item is a valid MAC address
    RegExp regExp = new RegExp(
      r"([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})",
      caseSensitive: false,
      multiLine: false,
    );
    if (!regExp.hasMatch(item)) {
      //pop up an alert dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid MAC Address"),
            content: Text("Please enter a valid MAC address"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }


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
  void removeSelectedItems() {
    setState(() {
      for (int i = selectedItemStatus.length - 1; i >= 0; i--) {
        if (selectedItemStatus[i]) {
          selectableItems.removeAt(i);
          selectedItemStatus.removeAt(i);
        }
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // Color of the border
                  width: 2.0, // Width of the border
                ),
              ),
              child: ListView.builder(
                shrinkWrap: true,
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'RSSI Threshold Value: ' + rssi,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Mode: '),
                      Switch(
                        value: isWhitelistMode,
                        onChanged: (value) {
                          setState(() {
                            isWhitelistMode = value;
                          });
                        },
                      ),
                      Text(isWhitelistMode ? 'Whitelist' : 'Blacklist'),
                      Spacer(),
                      const Text('Threshold: '),
                      Switch(
                        value: isThresholdEnabled,
                        onChanged: (value) {
                          setState(() {
                            isThresholdEnabled = value;
                          });
                        },
                      ),
                      Text(isThresholdEnabled ? 'Enabled' : 'Disabled'),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter scan interval (ms)',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            scanInterval = int.tryParse(value) ?? 5000;
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Enter scan duration (ms)',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            scanDuration = int.tryParse(value) ?? 5000;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                      ),
                      ElevatedButton(
                        onPressed: () {
                          removeSelectedItems();
                        },
                        child: Text('Delete MAC List'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                  Expanded(
                  child: TextFormField(
                  controller: _controller1,
                    decoration: const InputDecoration(
                      hintText: 'Enter MAC address to be added to the list',
                    ),

                  ),
            ),

                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          addItem(_controller1.text);
                        },
                        child: const Text('Add Mac to List'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
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
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setRssiThreshold(_controller2.text);
                        },
                        child: const Text('Set RSSI Threshold'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      print(buildJson());
                    },
                    child: const Text('Print JSON'),
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle the second button press
                    },
                    child: const Text('Upload Configurations'),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  void setRssiThreshold(String text) {
    setState(() {
      rssi = text;
    });



  }


}
