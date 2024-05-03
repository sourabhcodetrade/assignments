import 'package:flutter/material.dart';
import 'package:supabase_chat_application/app/utils/routes/routes.dart';

import '../chat/controller/chat_controller.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ChatController().signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.loginScreen, (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              elevation: 4.0,
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, Routes.infoScreen);

                },
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'See All Users',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              elevation: 4.0,
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, Routes.chatScreen);

                },
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  'Go to Chat Screen',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
