import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tts/Screens/text_screen.dart';
import 'package:tts/constant/color.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tts/utility%20functions/file_download.dart';

class Player extends StatefulWidget {
  
  final Uint8List audioData;
  final String text;
  const Player({Key? key, required this.audioData, required this.text}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {


  TextEditingController _controller = TextEditingController();
  final audioPlayer = AudioPlayer();
  bool _isplaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  Future<File> _saveAudioToFile(Uint8List data) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/text_to_speech.mp3';

    final file = File(filePath);
    await file.writeAsBytes(data);

    return file;
  }
  @override
  void initState() {
    super.initState();
    
    

    audioPlayer.onPlayerStateChanged.listen((state) { 
      setState(() {
        _isplaying = state == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) { 
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer.onPositionChanged.listen((newPosition) { 
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose(){
    audioPlayer.dispose();
    super.dispose();
  }
  String formatTime(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final second = twoDigits(duration.inSeconds.remainder(60));
    return[
      if(duration.inHours > 0) hours,
      minutes,
      second,
    ].join(':');

  }
void downloadAudio() async {
    await FileOperations.downloadAudio(_controller.text,widget.audioData, context);
  }


  @override
  Widget build(BuildContext context) {
    String displayedname = widget.text.length > 10
        ? '${widget.text.substring(0, 10)}...'
        : widget.text;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        elevation: 0.0,
        actions: [
          IconButton(
            splashColor: black,
            highlightColor: black,
            onPressed: (){
             
              
             
            },
             icon: Icon(Icons.restart_alt_rounded, color: white, size: 40,)
             ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/icons/player.gif',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(displayedname, style: TextStyle(color: white, fontSize: 24, fontFamily: "Medium"),),
            const SizedBox(height: 4),
            Text('Text to Speech', style: TextStyle(color: black_500, fontSize: 15, fontFamily: "Regular"),),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
               onChanged: (value) async{
                // final position = Duration(seconds: value.toInt());
                // await audioPlayer.seek(position);
                // await audioPlayer.resume();
               }
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Text(formatTime(position), style: TextStyle(color: black_500, fontSize: 12, fontFamily: 'Regular'),),
                   Text(formatTime(duration - position), style: TextStyle(color: black_500, fontSize: 12, fontFamily: 'Regular'),)
                  ],
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(top: 30),
                 
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    
                     Expanded(
                       child: Padding(
                         padding: const EdgeInsets.only(left: 40),
                         child: CircleAvatar(
                           radius: 35,
                           child: IconButton(
                            splashColor: black,
                            highlightColor: black,
                             icon: Icon(
                              _isplaying ? Icons.pause : Icons.play_arrow,
                             ),
                             iconSize: 50,
                             color: white,
                             onPressed: ()async{
                              if(_isplaying){
                                await audioPlayer.pause();
                              }else{
                                
                               final file = await _saveAudioToFile(widget.audioData);
                               audioPlayer.setSourceDeviceFile(file.path);
                               audioPlayer.play(DeviceFileSource(file.path));
                              }
                             },
                             ),
                                      
                         ),
                       ),
                     ),
                      IconButton(
                        splashColor: black,
                        highlightColor: black,
                        onPressed: (){
                        _showDialog(context);
                      }, 
                      icon: Icon(Icons.download_rounded, color: white, size: 30,)
                      ),
                   ],
                 ),
               ),
      
      
           
          ],
        ),
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
          content: TextFormField(
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
                if(_controller.text.isEmpty){
                  Fluttertoast.showToast(
            msg: 'Enter file name please',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
                }else{
                  downloadAudio();
                Navigator.of(context).pop();
                }
              },
              child: Text('Download',style: TextStyle(fontFamily: 'Medium', fontSize: 15, color: black),),
            ),
          ],
        );
      },
    );
  }

}
