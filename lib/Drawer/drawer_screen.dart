import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:tts/Screens/text_screen.dart';
import 'package:tts/constant/color.dart';

import 'menu_screen.dart';



class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController(); // Declare the controller

 

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuBackgroundColor: primary,
      controller: zoomDrawerController,
      menuScreen: const MenuScreen(),
      mainScreen: const TextScreen(),
      borderRadius: 24.0,
      androidCloseOnBackTap: true,
      mainScreenTapClose: true,
      angle: -12.0,
      slideWidth: MediaQuery.of(context).size.width * 0.75,
    );
  }
}
