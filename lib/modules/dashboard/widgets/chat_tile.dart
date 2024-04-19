import 'package:flutter/material.dart';

class ChatMessageTile extends StatelessWidget {
  final Map<String, dynamic> message;

  const ChatMessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message['created_at']),
          Card(
            elevation: 8,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              textColor: Colors.white,
              title: Text(message['message']),
              tileColor: Colors.blueAccent,
              trailing: Text('Author ID: ${message['author_id']}'),
              // You can customize the ListTile as per your requirement
            ),
          ),
        ],
      ),
    );
  }
}
