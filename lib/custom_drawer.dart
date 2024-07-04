import 'package:flutter/material.dart';
import 'configurationsPage.dart'; // Ensure this file defines a Page1 class
import 'page2.dart'; // Ensure this file defines a Page2 class
import 'main.dart';
import 'log_history.dart';

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
            leading: Icon(Icons.home),
            title: Text('Main Page'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyHomePage(title: 'Home',)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.one_k),
            title: Text('Configurations Page'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Page1()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.two_k),
            title: Text('Monitoring Page'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Page2()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.three_k),
            title: Text('History And Logs Page'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LogHistoryPage()),
              );

            }
          )
        ],
      ),
    );
  }
}