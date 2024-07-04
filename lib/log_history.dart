import 'package:flutter/material.dart';
import 'custom_drawer.dart'; // Assuming you have a custom drawer widget
import 'log_entry.dart'; // Assuming you have a LogEntry class

class LogHistoryPage extends StatefulWidget {
  const LogHistoryPage({Key? key}) : super(key: key);

  @override
  _LogHistoryPageState createState() => _LogHistoryPageState();
}

class _LogHistoryPageState extends State<LogHistoryPage> {
  List<LogEntry> logEntries = []; // List to hold log entries

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log History'),
      ),
      drawer: CustomDrawer(), // Replace with your custom drawer widget
      body: _buildLogList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example of adding a new log entry
          setState(() {
            logEntries.add(LogEntry(DateTime.now(), 'New log entry added.'));
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildLogList() {
    return ListView.builder(
      itemCount: logEntries.length,
      itemBuilder: (context, index) {
        var logEntry = logEntries[index];
        return ListTile(
          title: Text('${logEntry.dateTime}: ${logEntry.message}'),
        );
      },
    );
  }
}
