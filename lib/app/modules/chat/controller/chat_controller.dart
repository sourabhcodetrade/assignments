import 'package:supabase_chat_application/app/utils/constants/constants.dart';

class ChatController {
  Future<void> signOut() async {
    await Constants.supabase.auth.signOut();
  }

  Future<void> deleteMessage(String id) async {
    final response =
        await Constants.supabase.from('messages').delete().eq('id', id);
    print(response);
  }
}
