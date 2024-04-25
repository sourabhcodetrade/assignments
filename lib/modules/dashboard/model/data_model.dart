import 'package:graphql_flutter/graphql_flutter.dart';

class DataModel {
  int statusCode;
  QueryResult? data;
  bool successState = false;
  String exceptionMessage;

  DataModel(this.statusCode, this.data, this.successState,this.exceptionMessage);
}
