import 'package:flutter/material.dart';
import 'package:project3/models/call.dart';
import 'package:project3/theme.dart';

class CallView extends StatelessWidget {
  const CallView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final status = callList[index];
        return ListTile(
          leading: const Icon(
            Icons.account_circle,
            size: 50,
            color: Colors.black45,
          ),
          title: Text(
            status.name,
            style: chatTitleStyle,
          ),
          subtitle: Row(
            children: [
              Icon(
                Icons.call_received, // Using call icon for consistency
                color: status.incomeCall ? Colors.green : Colors.red,
                size: 16,
              ),
              SizedBox(width: 5),
              Text(
                status.callsDate,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.call,
                color: WhatsAppLightGreen, size: 24
            ),
            onPressed: () {
              // Handle call action
            },
          ),
        );
      },
      itemCount: callList.length,
    );
  }
}
