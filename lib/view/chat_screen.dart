// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../utils/routes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  final TextEditingController messageController = TextEditingController();
  late final String username;
  late final String ip;

  List<dynamic> messages = [];

  _connectSocket() {
    socket.onConnect((_) {
      print('connection established');
      socket.emit('connected', {'username': username});
    });
    socket.onDisconnect((data) {
      print('disconnect');
    });
    socket.onConnectError((data) => print('Connection Error $data'));
    socket.on('message', (data) {
      messages = data;
      setState(() {});
    });
    socket.on('newUser', (username) {
      print('new user = $username');


    });
    socket.on('userLeft', (username) {
      print('userLeft = $username');
    });
  }

  _sendMessage(String text) {
    socket.emit('message', {
      'message': text,
      'sender': username,
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      username = routeArgs['username']!;
      ip = routeArgs['ip']!;
      print('ip= $ip');
      socket = IO.io(
          'http://$ip:3000',
          IO.OptionBuilder().setTransports(['websocket']).setQuery(
              {'username': username}).build());
      _connectSocket();
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  void _handleSubmitted(String text) {
    if (messageController.text.trim().isNotEmpty) {
      _sendMessage(text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              socket.emit('disconnected', {'username': username});
              socket.disconnect();
              Navigator.pushReplacementNamed(context, Routes.welcomeScreen);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: messages.length,
              itemBuilder: (_, int index) {
                bool isMe = username == messages[index]['sender'];
                final Container message = Container(
                  margin: isMe
                      ? const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
                      : const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blueAccent[200] : Colors.yellowAccent,
                    borderRadius: isMe
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                          )
                        : const BorderRadius.only(
                            topRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                          ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        messages[index]['sender'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isMe ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        messages[index]['message'],
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                );
                return Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: <Widget>[
                    message,
                    Text(
                      '${messages[index]['hours']} : ${messages[index]['min']}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).primaryColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: messageController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(
                  Icons.send,
                  color: Colors.blueAccent,
                ),
                onPressed: () => _handleSubmitted(messageController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
