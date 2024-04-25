class Constants {
  Constants._();
  static const String supabaseUrl = 'https://psipneckyahgxfradhst.supabase.co';
  static const String graphqlUrl =
      'https://psipneckyahgxfradhst.supabase.co/graphql/v1';
  static const String apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBzaXBuZWNreWFoZ3hmcmFkaHN0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM1MDU5MzQsImV4cCI6MjAyOTA4MTkzNH0.4IUjsHrF2EaZrJeG_6FpjO0yx5Q0QMi0c_hSLMh8MSs';
  //  static const String readMessages = '''
  // ''';
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
