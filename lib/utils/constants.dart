class Constants {
  Constants._();
  static const String supabaseUrl = 'https://psipneckyahgxfradhst.supabase.co';
  static const String graphqlUrl =
      'https://psipneckyahgxfradhst.supabase.co/graphql/v1';
  static const String apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBzaXBuZWNreWFoZ3hmcmFkaHN0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM1MDU5MzQsImV4cCI6MjAyOTA4MTkzNH0.4IUjsHrF2EaZrJeG_6FpjO0yx5Q0QMi0c_hSLMh8MSs';

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

  static String insertQuery(String message, String authorId) {
    return '''mutation {
  insertIntomessagesCollection(objects: [{message: "$message", author_id: "$authorId"}]) {
    affectedCount
    records {
      id
      message
      author_id
      created_at
    }
  }
}''';
  }

  static String deleteQuery(String id) {
    return '''
  mutation {
  deleteFrommessagesCollection(filter: {id: {eq: "$id"}}) {
    affectedCount
    records {
      id
      message
    }
  }
}

   ''';
  }

  static String updateQuery(String message, String id) {
    return '''
     mutation {
  updatemessagesCollection(set: {message: "$message"}, filter: {id: {eq: "$id"}}) {
    affectedCount
    records {
      id
      message
      author_id
      created_at
    }
  }
}
''';
  }
}
