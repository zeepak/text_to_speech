import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:just_audio/just_audio.dart';
import 'package:tts/Data/data.dart';
import 'package:tts/services/api_services.dart';
import 'package:tts/utility%20functions/audio_player.dart';
import 'package:tts/utility%20functions/selection_functions.dart';
import '../utility functions/file_download.dart';



class TextToSpeechApp extends StatefulWidget {
  const TextToSpeechApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TextToSpeechAppState createState() => _TextToSpeechAppState();
}

class _TextToSpeechAppState extends State<TextToSpeechApp> {
  final TextEditingController textController = TextEditingController();
  Uint8List? audioData;
  final player = AudioPlayer();
  bool isAudioAvailable = false;
  String selectedLanguageCode = 'en-us';
  String selectedvoicecode = 'Linda';
  
  Future<void> convertTextToSpeech(String text) async {
    TextToSpeechService.convertTextToSpeech(
      text: text,
      selectedLanguageCode: selectedLanguageCode,
      selectedVoiceCode: selectedvoicecode,
      player: player,
      onAudioAvailable: (audioData) {
        setState(() {
          this.audioData = audioData;
          isAudioAvailable = true;
          print('Text to speech done.');
        });
      },
      onError: (error) {
        print(error);
      },
    );
  }

  void audioplayer() async {
    if (audioData != null) {
      PlayAudio(audioData!);
    }
  }

 void downloadAudio() async {
    await FileOperations.downloadAudio(audioData!, context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text to Speech App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           TextButton(
  onPressed: _showLanguageBottomSheet,
  child: Text('Select Language: ${supportedLanguages.firstWhere((lang) => lang['code'] == selectedLanguageCode)['name']}'),
),

TextButton(
  onPressed: _showVoiceBottomSheet,
  child: Text('Select Voice: ${supportedvoice.firstWhere((voice) => voice['code'] == selectedvoicecode)['name']}'),
),
            const SizedBox(height: 16.0),
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: 'Enter Text'),
            ),
            const SizedBox(height: 16.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Show a loading indicator while converting text to speech
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
                await convertTextToSpeech(textController.text);
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                  },
                  child: const Text('Convert to Speech'),
                ),
              
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: downloadAudio,
                    child: const Text('Download Audio'),
                  ),
                ),
                isAudioAvailable ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed: audioplayer, 
                    child: const Text('Play Audio'),
                    ),
                ) : const SizedBox(),

              ],
            ),
          ],
        ),
      ),
    );
  }
  
}