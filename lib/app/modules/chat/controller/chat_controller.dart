import 'package:get/get.dart';
import 'package:supabase_chat_application/app/utils/constants/constants.dart';

class ChatController extends GetxController {
  Future<void> signOut() async {
    await Constants.supabase.auth.signOut();
  }
}
