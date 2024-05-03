import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Constants {
  static const String supabaseUrl = 'https://pguhfxcsqzcarftclhbm.supabase.co';
  static const String graphqlUrl =
      'https://pguhfxcsqzcarftclhbm.supabase.co/graphql/v1';
  static const String apiKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBndWhmeGNzcXpjYXJmdGNsaGJtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTQ3Mjc1OTYsImV4cCI6MjAzMDMwMzU5Nn0.ZOtV9EcirT9eKTJeBh0m4FgQOP9lVis5PtQ1qQxYnUs';

  static final supabase = Supabase.instance.client;

  static const preloader =
      Center(child: CircularProgressIndicator(color: Colors.orange));

  static const formSpacer = SizedBox(width: 16, height: 16);

  static const formPadding = EdgeInsets.symmetric(vertical: 20, horizontal: 16);

  static const unexpectedErrorMessage = 'Unexpected error occurred.';
}
