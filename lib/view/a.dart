import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Message> messages = [
    Message(
      sender: 'John',
      text: 'Hello!',
      time: DateTime.now().subtract(const Duration(minutes: 5)),
      isMe: false,
    ),
    Message(
      sender: 'Jane',
      text: 'Hi there!',
      time: DateTime.now().subtract(const Duration(minutes: 3)),
      isMe: false,
    ),
    Message(
      sender: 'John',
      text: 'How are you?',
      time: DateTime.now().subtract(const Duration(minutes: 2)),
      isMe: false,
    ),
  ];

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      messages.insert(
        0,
        Message(
          sender: 'Me',
          text: text,
          time: DateTime.now(),
          isMe: true,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(8.0),
              itemCount: messages.length,
              itemBuilder: (_ , int index) => messages[index],
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
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
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String sender;
  final String text;
  final DateTime time;
  final bool isMe;

  const Message({super.key, required this.sender, required this.text, required this.time, required this.isMe});

  @override
  Widget build(BuildContext context) {
    final Container message = Container(
      margin: isMe
          ? const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
          : const EdgeInsets.only(top: 8.0, bottom: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isMe ? Colors.blue[200] : Colors.grey[300],
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
            sender,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isMe ? Colors.black : Colors.black87,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            text,
            style: TextStyle(
              color: isMe ? Colors.black : Colors.black87,
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
          '${time.hour}:${time.minute}',
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}