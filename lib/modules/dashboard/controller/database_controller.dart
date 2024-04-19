import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseController {
  final supabase = Supabase.instance.client;

  List<Map<String, dynamic>> listenToChatMessages() {
    List<Map<String, dynamic>> messages = [];

    supabase.from('messages').stream(primaryKey: ['id']).listen(
      (List<Map<String, dynamic>> data) {
        messages.addAll(data);
        // print(data);
      },
    );

    return messages;
  }

  Future<void> insertData() async {
    await supabase.from('messages').insert(
      {'message': 'The Shire', 'author_id': 554},
    );
  }

  static const String readMessages = '''
 query MessagesCollection {
    messagesCollection {
        edges {
            node {
                id
                created_at
                message
                author_id
            }
        }
    }
}
''';
}
