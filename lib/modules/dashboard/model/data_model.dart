import 'package:graphql_flutter/graphql_flutter.dart';

class DataModel {
  int statusCode;
  QueryResult data;
  bool success = false;

  DataModel(this.statusCode, this.data,this.success);
}
