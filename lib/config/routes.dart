import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';

import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/register_screen.dart';
import '../pages/main_page.dart';


final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const LoginScreen(),
  '/home': (context) => const  MainPage(),
  '/register': (context) => const RegisterScreen(),
  '/forgot-password': (context) => const ForgotPasswordScreen(),

};


