import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tts/constant/color.dart';
import 'package:tts/utility%20functions/audio_player.dart';
import '../utility functions/file_download.dart';

class Player extends StatefulWidget {
  final Uint8List audioData;
  const Player({super.key, required this.audioData});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  TextEditingController _controller = TextEditingController();

  


  void audioplayer() async {
    
    PlayAudio(widget.audioData);
    
  }
   void downloadAudio() async {
    await FileOperations.downloadAudio(_controller.text,widget.audioData, context);
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: audioplayer, 
            child: Text('Play')),
          ),
          Center(
            child: ElevatedButton(
              onPressed: (){
                _showDialog(context);
              }, 
            child: Text('Download')),
          ),
        ],
      ),
    );
  }
   Future<void> _showDialog(BuildContext context) async {
    

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: black_900,
          title: Text('Enter file name', style: TextStyle(fontFamily: 'Medium', color: white),),
          content: TextField(
            controller: _controller,
            style: TextStyle(color: white, fontFamily: 'Regular', fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Type here...',
              hintStyle: TextStyle(color: black_500,fontFamily: 'Regular', fontSize: 16),
              ),
          ),
          actions: [
            
            ElevatedButton(
              style:ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      
    )
  )
),
              onPressed: () {
                
                downloadAudio();

                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Download',style: TextStyle(fontFamily: 'Medium', fontSize: 15, color: black),),
            ),
          ],
        );
      },
    );
  }
}