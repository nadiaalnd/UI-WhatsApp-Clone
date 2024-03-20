import 'package:flutter/material.dart';
import 'package:project3/models/chart.dart';
import 'package:project3/theme.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final chat = chatList[index];
        return ListTile(
            leading: Image.network(
              chat.image,
            ),
            title: Text(
              chat.name,
              style: chatTitleStyle,
            ),
            subtitle: Text(
              chat.mostRecentMessage,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Text(
                chat.messageDate,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ));
      },
      itemCount: chatList.length,
    );
  }
}
