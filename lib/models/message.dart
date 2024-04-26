import 'package:flutter/material.dart';

class Message {
  final String message;
  final String sender;
  final DateTime sentAt;

  Message({
    required this.message,
    required this.sender,
    required this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> message) {
    return Message(
      message: message['message'],
      sender: message['sender'],
      sentAt: DateTime.fromMillisecondsSinceEpoch(
        message['sentAt'] * 1000,
      ),
    );
  }
}
