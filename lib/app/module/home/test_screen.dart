import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MessageModel {
  String userName, message;

  MessageModel({required this.userName, required this.message});

  factory MessageModel.fromJson(Map<Object?, Object?> json) {
    return MessageModel(
      userName: json["userName"] as String,
      message: json["message"] as String,
    );
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final DatabaseReference _reference = FirebaseDatabase.instance
      .ref()
      .child('channels')
      .child('c1')
      .child('messages');

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final List<MessageModel> _messageModel = [];
  final StreamController<List<MessageModel>> _messageStreamController =
      StreamController<List<MessageModel>>.broadcast();

  Stream<List<MessageModel>> get messageStream =>
      _messageStreamController.stream;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _reference.onChildAdded.listen((event) {
      final data = event.snapshot.value as Map;
      final newMessage = MessageModel.fromJson(data);
      _messageModel.add(newMessage);
      _messageStreamController.add(_messageModel);
      _scrollToBottom();
    });
  }

  Future<void> _sendMessage() async {
    String userName = _userController.text;
    String message = _messageController.text;

    if (userName.isNotEmpty && message.isNotEmpty) {
      final timeStamp =
          _reference.child('message_${DateTime.now().millisecondsSinceEpoch}');
      await timeStamp.set({"userName": userName, "message": message});
      // _userController.clear();
      // _messageController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter both user name and message')),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<List<MessageModel>>(
                stream: messageStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No messages');
                  }

                  return SizedBox(
                    height: 500,
                    child: ListView.separated(
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.grey,
                          height: 50,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text("User: ${snapshot.data![index].userName}"),
                              Text("Message: ${snapshot.data![index].message}"),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: snapshot.data!.length,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  decoration: const InputDecoration(hintText: "User name"),
                  controller: _userController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: _messageController,
                  decoration: const InputDecoration(hintText: "Message"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _sendMessage,
                child: const Text('Send Msg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
