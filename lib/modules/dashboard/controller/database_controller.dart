import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:supabase_example/modules/dashboard/model/data_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../utils/constants.dart';

class DatabaseController {
  static GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink(Constants.graphqlUrl, defaultHeaders: {
      'apiKey': Constants.apiKey,
    }),
  );


  Future<DataModel> queryHandler(String query) async {
    try {
      late QueryResult data;
      data = await client
          .query(QueryOptions(document: gql(query)));
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

  //supabase methods

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
}
