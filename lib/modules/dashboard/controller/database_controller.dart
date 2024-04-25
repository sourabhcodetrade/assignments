import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:supabase_example/modules/dashboard/model/data_model.dart';
import '../../../utils/constants.dart';

class DatabaseController {
  static GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink(Constants.graphqlUrl, defaultHeaders: {
      'apiKey': Constants.apiKey,
    }),
  );

  Future<void> sendData() async {
    await client.query(
        QueryOptions(document: gql(Constants.insertQuery('new message', '9'))));
  }

  Future<void> updateData() async {
    await client.query(QueryOptions(
        document: gql(Constants.updateQuery('updated message', '13'))));
  }

  Future<void> deleteData() async {
    await client
        .query(QueryOptions(document: gql(Constants.deleteQuery('12'))));
  }

  Future<DataModel> fetchData() async {
    try {
      late QueryResult data;
      data = await client
          .query(QueryOptions(document: gql(Constants.readMessages)));
      String exceptionMessage = 'Something went wrong';
      if (data.hasException) {
        switch (data.exception?.linkException.runtimeType) {
          case UnknownException _:
            exceptionMessage = 'UnknownException';
            break;
          case CacheMisconfigurationException _:
            exceptionMessage = 'CacheMisconfigurationException';
            break;
          case ServerException _:
            exceptionMessage = 'ServerException';
            break;
          case MismatchedDataStructureException _:
            exceptionMessage = 'MismatchedDataStructureException';
            break;
          case CacheMissException _:
            exceptionMessage = 'CacheMissException';
            break;
        }

        return DataModel(401, null, false, exceptionMessage);
      }
      return DataModel(200, data, true, '');
    } catch (e) {
      debugPrint(e.toString());
      return DataModel(401, null, false, 'Something Went Wrong');
    }
  }

// final supabase = Supabase.instance.client;
//
// List<Map<String, dynamic>> listenToChatMessages() {
//   List<Map<String, dynamic>> messages = [];
//
//   supabase.from('messages').stream(primaryKey: ['id']).listen(
//     (List<Map<String, dynamic>> data) {
//       messages.addAll(data);
//       // print(data);
//     },
//   );
//
//   return messages;
// }

// Future<void> insertData() async {
//   await supabase.from('messages').insert(
//     {'message': 'The Shire', 'author_id': 554},
//   );
// }
}
