import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tts/Drawer/drawer_screen.dart';
import 'package:tts/Screens/Splash/splash.dart';
import 'package:tts/constant/primary_theme.dart';
import 'package:tts/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Text to Speech App',
      theme: ThemeData(
        primarySwatch: Palette.kToDark,
      ),
      home: const Splash(),  
    );
  }
}

