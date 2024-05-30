import 'package:firebase_auth_project/app/module/auth/forgot_password/forgot_password_bloc/send_otp_bloc/send_otp_bloc.dart';
import 'package:firebase_auth_project/app/module/auth/forgot_password/forgot_password_bloc/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:firebase_auth_project/app/module/auth/signup/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../module/auth/change_password/change_password_bloc/change_password_screen_bloc.dart';
import '../../module/auth/change_password/view/change_password_screen.dart';
import '../../module/auth/forgot_password/view/forgot_password_screen.dart';
import '../../module/auth/login/login_bloc/login_screen_bloc.dart';
import '../../module/auth/login/view/login_screen.dart';
import '../../module/auth/signup/signup_bloc/singup_screen_bloc.dart';
import '../../module/onboard/view/splash_screen.dart';
import '../../module/onboard/view/under_development_screen.dart';
import '../contants/routes.dart';

final class NavigationManager {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    Map<String, dynamic>? args =
        routeSettings.arguments as Map<String, dynamic>?;
    return MaterialPageRoute(
      builder: (context) => getRouteScreen(
        routeName: routeSettings.name ?? "",
        args: args ?? {},
      ),
    );
  }

  static Widget getRouteScreen({
    required final String routeName,
    required final Map<String, dynamic> args,
  }) {
    return switch (routeName) {
      Routes.splashScreen => const SplashScreen(),
      Routes.loginScreen => BlocProvider(
          create: (BuildContext context) => LoginScreenBloc(),
          child: const LoginScreen()),
      Routes.signupScreen => BlocProvider(
          create: (BuildContext context) => SignUpScreenBloc(),
          child: const SignupScreen()),
      Routes.forgotPasswordScreen => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => SendOtpBloc()),
            BlocProvider(create: (_) => VerifyOtpBloc()),
          ],
          child: const ForgotPasswordScreen(),
        ),
      Routes.changePassword => BlocProvider(
          create: (BuildContext context) => ChangePasswordScreenBloc(),
          child: const ChangePasswordScreen()),
      _ => const UnderDevelopmentScreen(),
    };
  }
}
