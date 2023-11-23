import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tts/Screens/Splash/splash.dart';
import 'package:tts/constant/primary_theme.dart';
import 'package:tts/firebase_options.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
     systemNavigationBarColor: Colors.black
    ),
  );
  var devices = ['B8DC1672C49220C570C3226D5E8ED6CD'];
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  RequestConfiguration requestConfiguration = RequestConfiguration(testDeviceIds: devices);
  MobileAds.instance.updateRequestConfiguration(requestConfiguration);
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

