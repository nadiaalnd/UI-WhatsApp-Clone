import 'package:flutter/material.dart';

class Call {
  String name;
  String callsDate;
  bool incomeCall; // added property to represent incoming call

  Call({
    required this.name,
    required this.callsDate,
    required this.incomeCall,
  });
}

var callList = [
  Call(name: "Nadila", callsDate: "Today, 10:49 AM", incomeCall: true),
  Call(name: "Budi", callsDate: "Today, 10:39 AM", incomeCall: false),
  Call(name: "Ani", callsDate: "Today, 09:40 AM", incomeCall: true),
  Call(name: "Milo", callsDate: "Today, 09:30 AM", incomeCall: false),
  Call(name: "Joko", callsDate: "Yesterday, 08:20 AM", incomeCall: true),
  Call(name: "Roki", callsDate: "Yesterday, 08:07 AM", incomeCall: false),
];

class CallWidget extends StatelessWidget {
  final Call status;

  const CallWidget({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        // Placeholder avatar, you can replace it with actual avatars
        backgroundColor: Colors.grey,
        radius: 20,
      ),
      title: Text(status.name),
      subtitle: Text(status.callsDate),
      trailing: status.incomeCall
          ? Icon(Icons.call_received) // Icon for incoming call
          : SizedBox(), // If not incoming call, no icon is shown
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Status List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Status List'),
        ),
        body: ListView.builder(
          itemCount: callList.length,
          itemBuilder: (context, index) {
            final call = callList[index];
            return CallWidget(status: call);
          },
        ),
      ),
    );
  }
}
