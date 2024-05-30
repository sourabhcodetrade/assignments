import 'package:firebase_auth_project/app/module/auth/changePassword/changePasswordBloc/change_password_screen_bloc.dart';
import 'package:firebase_auth_project/app/module/auth/changePassword/view/change_password_screen.dart';
import 'package:firebase_auth_project/app/module/auth/forgotPassword/forgotPasswordBloc/forgot_password_screen_bloc.dart';
import 'package:firebase_auth_project/app/module/auth/forgotPassword/view/forgot_password_screen.dart';
import 'package:firebase_auth_project/app/module/auth/signup/signupBloc/singup_screen_bloc.dart';
import 'package:firebase_auth_project/app/module/auth/signup/view/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../module/auth/login/loginBloc/login_screen_bloc.dart';
import '../../module/auth/login/view/login_screen.dart';
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
      Routes.forgotPasswordScreen => BlocProvider(
          create: (BuildContext context) => ForgotPasswordScreenBloc(),
          child: const ForgotPasswordScreen()),
      Routes.changePassword => BlocProvider(
          create: (BuildContext context) => ChangePasswordScreenBloc(),
          child: const ChangePasswordScreen()),
      _ => const UnderDevelopmentScreen(),
    };
  }
}
