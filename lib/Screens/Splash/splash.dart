import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tts/Drawer/drawer_screen.dart';
import 'package:tts/Screens/Auth/login_screen.dart';
import 'package:tts/constant/color.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

 class _SplashState extends State<Splash> {

  final auth = FirebaseAuth.instance;
    @override
  void initState() {
    super.initState();
    
    Timer(
          const Duration(seconds: 2),
          () {
            if(FirebaseAuth.instance.currentUser != null){
    Navigator.pushAndRemoveUntil(
                      (context),
                      MaterialPageRoute(builder: (context) => const DrawerScreen()),
                      (route) => false);
   }else{
    Navigator.pushAndRemoveUntil(
                      (context),
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false);
   }
          }
              );
    
  }
  
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      backgroundColor: black,
      body: 
      Center(
        child: Image.asset('assets/icons/logo.png', height: 140, width: 140,),
      ),
     
    );
  }
}