import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:supabase_example/modules/dashboard/model/data_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../utils/constants.dart';

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

  Future<DataModel> fetchData() async {
    late QueryResult data;
    GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink(Constants.graphqlUrl, defaultHeaders: {
        'apiKey': Constants.apiKey,
      }),
    );
    data =
        await client.query(QueryOptions(document: gql(Constants.readMessages)));

    if (data.hasException) {
      return DataModel(401, data,false);
    }

    return DataModel(200, data,true);
  }
}
