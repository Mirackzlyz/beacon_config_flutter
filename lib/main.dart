import 'package:flutter/material.dart';
import 'configurationsPage.dart'; // Ensure this file defines a Page1 class
import 'page2.dart'; // Ensure this file defines a Page2 class
import 'custom_drawer.dart'; // Ensure this file defines a CustomDrawer class


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





