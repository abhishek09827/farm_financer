import 'package:farm_financer/login/welcome_screen.dart';
import 'package:farm_financer/screens/chat_bot.dart';
import 'package:farm_financer/screens/chat_page.dart';
import 'package:farm_financer/screens/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'common/color_extension.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farm Financier',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
        textTheme: const TextTheme(
            titleMedium: TextStyle(
              color: Colors.white
            )
        ),

        colorScheme: ColorScheme.fromSeed(
          seedColor: TColor.primary,
          background: TColor.gray80,
          primary: TColor.primary,
          primaryContainer: TColor.gray60,
          secondary: TColor.secondary,

        ),
      ),
      home: WelcomeScreen(),
    );
  }
}


