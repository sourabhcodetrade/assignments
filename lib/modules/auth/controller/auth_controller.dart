import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController {
  final supabase = Supabase.instance.client;
  Future<AuthResponse> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final authResponse =
        await supabase.auth.signUp(password: password, email: email);
    return authResponse;
  }

  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final authResponse = await supabase.auth
        .signInWithPassword(password: password, email: email);
    return authResponse;
  }

  Future<void> signInWithEmailAndOtp({
    required String email,
  }) async {
    await supabase.auth.signInWithOtp(email: email);
  }

  Future<void> verifyOtp({
    required String otp,
    required String email,
  }) async {
    await supabase.auth.verifyOTP(
      email: email,
      token: otp,
      type: OtpType.magiclink,
    );
  }

  Future<void> logOut() async {
    await supabase.auth.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static void registerUser(String userID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userID', userID);
  }
}
