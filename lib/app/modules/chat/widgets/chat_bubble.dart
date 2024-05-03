import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

import '../../../utils/constants/constants.dart';
import '../../models/message_model.dart';
import '../../models/profile_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.profile,
  });

  final MessageModel message;
  final ProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    List<Widget> chatContents = [
      CircleAvatar(
        child: profile == null
            ? Constants.preloader
            : Text(profile!.username.substring(0, 2)),
      ),
      const SizedBox(width: 12),
      Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: message.isMine
                ? Theme.of(context).primaryColor
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(message.content),
        ),
      ),
      const SizedBox(width: 12),
      Text(format(message.createdAt, locale: 'en')),
      const SizedBox(width: 60),
    ];
    if (message.isMine) {
      chatContents = chatContents.reversed.toList();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      child: Row(
        mainAxisAlignment:
            message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: chatContents,
      ),
    );
  }
}
