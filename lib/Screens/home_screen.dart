import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:tts/Data/data.dart';
import 'package:tts/Screens/player_screen.dart';
import 'package:tts/constant/color.dart';
import 'package:tts/services/api_services.dart';
import 'package:tts/utility%20functions/selection_functions.dart';



class TextToSpeechApp extends StatefulWidget {
  final String text;
  const TextToSpeechApp({super.key, required this.text});

  @override
  // ignore: library_private_types_in_public_api
  _TextToSpeechAppState createState() => _TextToSpeechAppState();
}

class _TextToSpeechAppState extends State<TextToSpeechApp> {
  Uint8List? audioData;
  final player = AudioPlayer();
  String selectedformat = '8khz_8bit_mono';
  String selectedLanguageCode = 'en-us';
  String selectedvoicecode = 'Linda';
  String selectedcodec = 'mp3';
  String selectedspeed = '0';
  double _sliderValue = 0;
  Future<void> convertTextToSpeech() async {
    try {
      showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
    TextToSpeechService.convertTextToSpeech(
      selectedspeed: selectedspeed,
      text: widget.text,
      selectedcodec: selectedcodec,
      selectedformat: selectedformat,
      
      selectedLanguageCode: selectedLanguageCode,
      selectedVoiceCode: selectedvoicecode,
      player: player,
      onAudioAvailable: (audioData) {
      
              setState(() {
                this.audioData = audioData;
              });

              
      },
      onError: (error) {
        
      },
    ), 
    message: Text('Converting text to speech...', style: TextStyle(fontFamily: 'Medium', fontSize: 15, color: white)),
    progress: CircularProgressIndicator(color: primary),
    decoration: BoxDecoration(
      color: black_900,
      borderRadius: BorderRadius.circular(20)
    ),
    ),
      ).then((_) {
      // Navigate to Player screen after conversion
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Player(audioData: audioData!, text: widget.text,)), (route) => false);
    });
      
    }catch (e) {
      print('Unexpected error: $e');
  }
  }
   Future<void> showProgress(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        convertTextToSpeech(),
        message: Text('Converting text to speech...'),
      ),
    );

    // Handle the result if needed
  }
 void _showLanguageBottomSheet() {
    showLanguageBottomSheet(context, (String selectedLanguage) {
      setState(() {
        selectedLanguageCode = selectedLanguage;
      });
    });
  }


 void _showVoiceBottomSheet() {
    showVoiceBottomSheet(context, (String selectedVoice) {
      setState(() {
        selectedvoicecode = selectedVoice;
      });
    });
  }
  void _showFormatBottomSheet() {
    showFormatBottomSheet(context, (String selectedFormat) {
      setState(() {
        selectedformat = selectedFormat;
      });
    });
  } 

  @override
  Widget build(BuildContext context) {
        String displayedText = widget.text.length > 10
        ? widget.text.substring(0, 10) + '...'
        : widget.text;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
           icon: Icon(Icons.arrow_back_ios_rounded, color: white,)
           ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 5),
                child: Text('Your Text', style: TextStyle(fontFamily: 'Regular', fontSize: 15, color: white),),
              ),
              InkWell(
                splashColor: black,
                  highlightColor: black,
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: black_900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                        displayedText,
                        style: TextStyle(fontFamily: 'Medium', fontSize: 16, color: white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.edit, color: primary,),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 5, top: 15),
                child: Text('Select Your Language', style: TextStyle(fontFamily: 'Regular', fontSize: 15, color: white),),
              ),
              InkWell(
                splashColor: black,
                  highlightColor: black,
                onTap: (){
                  _showLanguageBottomSheet();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: black_900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                        '${supportedLanguages.firstWhere((lang) => lang['code'] == selectedLanguageCode)['name']}',
                        style: TextStyle(fontFamily: 'Medium', fontSize: 16, color: white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(Icons.arrow_forward_ios_rounded, color: primary,),
                      )
                    ],
                  ),
                ),
              ),
                Padding(
                padding: const EdgeInsets.only(left: 5, top: 15),
                child: Text('Select Your Voice', style: TextStyle(fontFamily: 'Regular', fontSize: 15, color: white),),
              ),
                InkWell(
                  splashColor: black,
                  highlightColor: black,
                  onTap: _showVoiceBottomSheet,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: black_900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                          '${supportedvoice.firstWhere((voice) => voice['code'] == selectedvoicecode)['name']}',
                          style: TextStyle(fontFamily: 'Medium', fontSize: 16, color: white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.arrow_forward_ios_rounded, color: primary,),
                        )
                      ],
                    ),
                              ),
                  ),
                ),
                              Padding(
                padding: const EdgeInsets.only(left: 5, top: 15),
                child: Text('Select Audio Format', style: TextStyle(fontFamily: 'Regular', fontSize: 15, color: white),),
              ),
                InkWell(
                  splashColor: black,
                  highlightColor: black,
                  onTap: _showFormatBottomSheet,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: black_900,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                          '${supportedformat.firstWhere((format) => format['code'] == selectedformat)['name']}',
                          style: TextStyle(fontFamily: 'Medium', fontSize: 16, color: white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.arrow_forward_ios_rounded, color: primary,),
                        )
                      ],
                    ),
                              ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Select Audio Codec:', style: TextStyle(fontFamily: 'Regular', fontSize: 16, color: white)),
                      DropdownButton<String>(
                        iconEnabledColor: primary,
                        iconDisabledColor: primary,
                        style: TextStyle(color: white),
                  value: selectedcodec,
                  dropdownColor: black_900,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedcodec = newValue!;
                    });
                  },
                  items: supportedcodec.map<DropdownMenuItem<String>>((Map<String, String> codec) {
                    return DropdownMenuItem<String>(
                      value: codec['code'],
                      child: Text(codec['name']!),
                    );
                  }).toList(),
                            ),
                    ],
                
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Slider(
                            min: -10,
                            max: 10,
                            value: _sliderValue,
                            onChanged: (value) {
                              setState(() {
                                _sliderValue = value;
                                selectedspeed = _sliderValue.round().toString();
                              });
                            },
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        
                        Text('Speed: ${_sliderValue.round()}', style: TextStyle(fontFamily: 'Regular', color: white, fontSize: 13),),
                      ],
                    ),
                  ),
                Padding(
                 padding: const EdgeInsets.only(left: 70, right: 70, top: 30),
                 child: InkWell(
                  splashColor: black,
                  highlightColor: black,
                  onTap: (){
                   
              
              convertTextToSpeech();
            
                  },
                   child: Container(
                          height: 51,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(27),
                            
                          ),
                          child:  Center(child: Text('Convert', style: TextStyle(fontFamily: 'SemiBold', fontSize: 18, color: black),)),
                         ),
                 ),
               ),
        
            ],
          ),
        ),
      ),
    );
  }
  
}