import 'package:flutter/material.dart';
import 'package:tts/Screens/text_screen.dart';
import 'package:tts/constant/primary_theme.dart';



void main() => runApp(
    const MyApp(),
  );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      // useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      title: 'Text to Speech App',
      theme: ThemeData(
          primarySwatch: Palette.kToDark,
        ),
      home: const TextScreen(),
    );
  }
}


