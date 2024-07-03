import 'package:flutter/material.dart';
import 'configurationsPage.dart'; // Ensure this file defines a Page1 class
import 'page2.dart'; // Ensure this file defines a Page2 class

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