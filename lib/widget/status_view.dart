import 'package:flutter/material.dart';
import 'package:project3/models/status.dart';
import 'package:project3/theme.dart';

class StatusView extends StatelessWidget {
  const StatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: statusList.length,
      itemBuilder: (context, index) {
        final status = statusList[index];
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
            subtitle: Text(
              status.statusDate,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          );
      },
    );
  }
}
