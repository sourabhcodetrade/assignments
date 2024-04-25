class Queries {
  String readMessages = '''
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

  String insertQuery(String message, String authorId) {
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

  String deleteQuery(String id) {
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

  String updateQuery(String message, String id) {
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
