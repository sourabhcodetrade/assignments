import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_chat_application/app/modules/models/message_model.dart';
import 'package:supabase_chat_application/app/modules/models/profile_model.dart';
import 'package:supabase_chat_application/app/utils/constants/constants.dart';
import '../../../utils/routes/routes.dart';
import '../controller/chat_controller.dart';
import '../widgets/chat_bubble.dart';
import 'message_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final Stream<List<MessageModel>> _messagesStream;
  final Map<String, ProfileModel> _profileCache = {};

  @override
  void initState() {
    final myUserId = Constants.supabase.auth.currentUser!.id;
    _messagesStream = Constants.supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map((maps) => maps
            .map((map) => MessageModel.fromMap(map: map, myUserId: myUserId))
            .toList());
    EasyLoading.instance
      ..maskType = EasyLoadingMaskType.black
      ..toastPosition = EasyLoadingToastPosition.center
      ..maskColor = Colors.amber
      ..indicatorType = EasyLoadingIndicatorType.pulse;
    super.initState();
  }

  Future<void> _loadProfileCache(String profileId) async {
    if (_profileCache[profileId] != null) {
      return;
    }
    final data = await Constants.supabase
        .from('profiles')
        .select()
        .eq('id', profileId)
        .single();
    final profile = ProfileModel.fromMap(data);
    setState(() {
      _profileCache[profileId] = profile;
    });
  }

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
      body: StreamBuilder<List<MessageModel>>(
        stream: _messagesStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: messages.isEmpty
                      ? const Center(
                          child: Text('Start your conversation now :)'),
                        )
                      : ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            _loadProfileCache(message.profileId);
                            return ChatBubble(
                              message: message,
                              profile: _profileCache[message.profileId],
                            );
                          },
                        ),
                ),
                const MessageBar(),
              ],
            );
          } else {
            return Constants.preloader;
          }
        },
      ),
    );
  }
}
