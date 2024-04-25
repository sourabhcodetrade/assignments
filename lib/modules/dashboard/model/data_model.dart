import 'package:graphql_flutter/graphql_flutter.dart';

class DataModel {
  int statusCode;
  QueryResult data;

  DataModel(this.statusCode, this.data);
}
