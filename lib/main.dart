import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'screens/auth_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firechat',
      theme: ThemeData(
        primaryColor: CustomColors.primaryColor,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: CustomColors.primaryColor,
          primaryVariant: CustomColors.primaryColor,
          secondary: CustomColors.accentColor,
          secondaryVariant: CustomColors.accentColor,
          surface: CustomColors.canvasColor,
          background: Colors.white,
          error: Colors.red,
          onPrimary: CustomColors.primaryColor,
          onSecondary: CustomColors.accentColor,
          onBackground: CustomColors.canvasColor,
          onError: Colors.red,
          onSurface: CustomColors.canvasColor,
        ),
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: CustomColors.accentColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: CustomColors.accentColor,
            textStyle: TextStyle(color: Colors.yellow),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: CustomColors.accentColor,
            textStyle: TextStyle(color: Colors.yellow),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, ss) {
          if (ss.connectionState == ConnectionState.waiting)
            return SplashScreen();
          if (ss.hasData)
            return ChatScreen();
          else
            return AuthScreen();
        },
      ),
    );
  }
}

class CustomColors {
  static const _primary = 0xFFeb4100;

  static const MaterialColor primaryColor = const MaterialColor(
    _primary,
    const <int, Color>{
      50: const Color(0xFFeb4100),
      100: const Color(0xFFeb4100),
      200: const Color(0xFFeb4100),
      300: const Color(0xFFeb4100),
      400: const Color(0xFFeb4100),
      500: const Color(0xFFeb4100),
      600: const Color(0xFFeb4100),
      700: const Color(0xFFeb4100),
      800: const Color(0xFFeb4100),
      900: const Color(0xFFeb4100),
    },
  );

  static const _accent = 0xFF05a4e4;

  static const MaterialColor accentColor = const MaterialColor(
    _accent,
    const <int, Color>{
      50: const Color(0xFF05a4e4),
      100: const Color(0xFF05a4e4),
      200: const Color(0xFF05a4e4),
      300: const Color(0xFF05a4e4),
      400: const Color(0xFF05a4e4),
      500: const Color(0xFF05a4e4),
      600: const Color(0xFF05a4e4),
      700: const Color(0xFF05a4e4),
      800: const Color(0xFF05a4e4),
      900: const Color(0xFF05a4e4),
    },
  );

  static const _canvas = 0xfff39571;

  static const MaterialColor canvasColor = const MaterialColor(
    _canvas,
    const <int, Color>{
      50: const Color(0xfff39571),
      100: const Color(0xfff39571),
      200: const Color(0xfff39571),
      300: const Color(0xfff39571),
      400: const Color(0xfff39571),
      500: const Color(0xfff39571),
      600: const Color(0xfff39571),
      700: const Color(0xfff39571),
      800: const Color(0xfff39571),
      900: const Color(0xfff39571),
    },
  );
}
