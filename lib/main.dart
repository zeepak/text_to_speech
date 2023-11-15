
import 'package:device_preview/device_preview.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'dart:io';

import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';



void main() => runApp(
    DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(), // Wrap your app
  ),
  );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Text to Speech App',
      home: const TextToSpeechApp(),
    );
  }
}

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
    final List<Map<String, String>> supportedLanguages = [

{"code": "ar-eg", "name": "Arabic (Egypt)"},
{"code": "ar-sa", "name": "Arabic (Saudi Arabia)"},
{"code": "bg-bg", "name": "Bulgarian"},
{"code": "ca-es", "name": "Catalan"},
{"code": "zh-cn", "name": "Chinese (China)"},
{"code": "zh-hk", "name": "Chinese (Hong Kong)"},
{"code": "zh-tw", "name": "Chinese (Taiwan)"},
{"code": "hr-hr", "name": "Croatian"},
{"code": "cs-cz", "name": "Czech"},
{"code": "da-dk", "name": "Danish"},
{"code": "nl-be", "name": "Dutch (Belgium)"},
{"code": "nl-nl", "name": "Dutch (Netherlands)"},
{"code": "en-au", "name": "English (Australia)"},
{"code": "en-ca", "name": "English (Canada)"},
{"code": "en-gb", "name": "English (Great Britain)"},
{"code": "en-in", "name": "English (India)"},
{"code": "en-ie", "name": "English (Ireland)"},
{"code": "en-us", "name": "English (United States)"},
{"code": "fi-fi", "name": "Finnish"},
{"code": "fr-ca", "name": "French (Canada)"},
{"code": "fr-fr", "name": "French (France)"},
{"code": "fr-ch", "name": "French (Switzerland)"},
{"code": "de-at", "name": "German (Austria)"},
{"code": "de-de", "name": "German (Germany)"},
{"code": "de-ch", "name": "German (Switzerland)"},
{"code": "el-gr", "name": "Greek"},
{"code": "he-il", "name": "Hebrew"},
{"code": "hi-in", "name": "Hindi"},
{"code": "hu-hu", "name": "Hungarian"},
{"code": "id-id", "name": "Indonesian"},
{"code": "it-it", "name": "Italian"},
{"code": "ja-jp", "name": "Japanese"},
{"code": "ko-kr", "name": "Korean"},
{"code": "ms-my", "name": "Malay"},
{"code": "nb-no", "name": "Norwegian"},
{"code": "pl-pl", "name": "Polish"},
{"code": "pt-br", "name": "Portuguese (Brazil)"},
{"code": "pt-pt", "name": "Portuguese (Portugal)"},
{"code": "ro-ro", "name": "Romanian"},
{"code": "ru-ru", "name": "Russian"},
{"code": "sk-sk", "name": "Slovak"},
{"code": "sl-si", "name": "Slovenian"},
{"code": "es-mx", "name": "Spanish (Mexico)"},
{"code": "es-es", "name": "Spanish (Spain)"},
{"code": "sv-se", "name": "Swedish"},
{"code": "ta-in", "name": "Tamil"},
{"code": "th-th", "name": "Thai"},
{"code": "tr-tr", "name": "Turkish"},
{"code": "vi-vn", "name": "Vietnamese"},

  ];
  
final List<Map<String, String>> supportedvoice = [
    {'code': 'Heading', 'name': 'Arabic Egypt'},
    {'code': 'Oda', 'name': 'Oda(Female)'},
    {'code': 'Heading', 'name': 'Arabic Saudi Arabia'},
    {'code': 'Salim', 'name': 'Salim(Male)'},
    {'code': 'Heading', 'name': 'Bulgarian'},
    {'code': 'Dimo', 'name': 'Dimo(Male)'},
    {'code': 'Heading', 'name': 'Catalan'},
    {'code': 'Rut', 'name': 'Rut(Female)'},
    {'code': 'Heading', 'name': 'Chinese China'},
    {'code': 'Luli', 'name': 'Luli(Female)'},
    {'code': 'Shu', 'name': 'Shu(Female)'},
    {'code': 'Chow', 'name': 'Chow(Female)'},
    {'code': 'Wang', 'name': 'Wang(Male)'},
    {'code': 'Heading', 'name': 'Chinese Hong Kong'},
    {'code': 'Jia', 'name': 'Jia(Female)'},
    {'code': 'Xia', 'name': 'Xia(Female)'},
    {'code': 'Chen', 'name': 'Chen(Male)'},
    {'code': 'Heading', 'name': 'Chinese Taiwan'},
    {'code': 'Akemi', 'name': 'Akemi(Female)'},
    {'code': 'Lin', 'name': 'Lin(Female)'},
    {'code': 'Lee', 'name': 'Lee(Male)'},
    {'code': 'Heading', 'name': 'Croatian'},
    {'code': 'Nikola', 'name': 'Nikola(Male)'},
    {'code': 'Heading', 'name': 'Czech'},
    {'code': 'Josef', 'name': 'Josef(Male)'},
    {'code': 'Heading', 'name': 'Danish'},
    {'code': 'Freja', 'name': 'Freja(Female)'},
    {'code': 'Heading', 'name': 'Dutch Belgium'},
    {'code': 'Daan', 'name': 'Daan(Male)'},
    {'code': 'Heading', 'name': 'Dutch Netherlands'},
    {'code': 'Lotte', 'name': 'Lotte(Female)'},
    {'code': 'Bram', 'name': 'Bram(Male)'},
    {'code': 'Heading', 'name': 'English Australia'},
    {'code': 'Zoe', 'name': 'Zoe(Female)'},
    {'code': 'Isla', 'name': 'Isla(Female)'},
    {'code': 'Evie', 'name': 'Evie(Female)'},
    {'code': 'Jack', 'name': 'Jack(Male)'},
    {'code': 'Heading', 'name': 'English Canada'},
    {'code': 'Rose', 'name': 'Rose(Female)'},
    {'code': 'Clara', 'name': 'Clara(Female)'},
    {'code': 'Emma', 'name': 'Emma(Female)'},
    {'code': 'Mason', 'name': 'Mason(Male)'},
    {'code': 'Heading', 'name': 'English Great Britain'},
    {'code': 'Alice', 'name': 'Alice(Female)'},
    {'code': 'Nancy', 'name': 'Nancy(Female)'},
    {'code': 'Lily', 'name': 'Lily(Female)'},
    {'code': 'Harry', 'name': 'Harry(Male)'},
    {'code': 'Heading', 'name': 'English India'},
    {'code': 'Eka', 'name': 'Eka(Female)'},
    {'code': 'Jai', 'name': 'Jai(Female)'},
    {'code': 'Ajit', 'name': 'Ajit(Male)'},
    {'code': 'Heading', 'name': 'English Ireland'},
    {'code': 'Oran', 'name': 'Oran(Male)'},
    {'code': 'Heading', 'name': 'English United States'},
    {'code': 'Linda', 'name': 'Linda(Female)'},
    {'code': 'Amy', 'name': 'Amy(Female)'},
    {'code': 'Mary', 'name': 'Mary(Female)'},
    {'code': 'John', 'name': 'John(Male)'},
    {'code': 'Mike', 'name': 'Mike(Male)'},
    {'code': 'Heading', 'name': 'Finnish'},
    {'code': 'Aada', 'name': 'Aada(Female)'},
    {'code': 'Heading', 'name': 'French Canada'},
    {'code': 'Emile', 'name': 'Emile(Female)'},
    {'code': 'Olivia', 'name': 'Olivia(Female)'},
    {'code': 'Logan', 'name': 'Logan(Female)'},
    {'code': 'Felix', 'name': 'Felix(Male)'},
    {'code': 'Heading', 'name': 'French France'},
    {'code': 'Bette', 'name': 'Bette(Female)'},
    {'code': 'Iva', 'name': 'Iva(Female)'},
    {'code': 'Zola', 'name': 'Zola(Female)'},
    {'code': 'Axel', 'name': 'Axel(Male)'},
    {'code': 'Heading', 'name': 'French Switzerland'},
    {'code': 'Theo', 'name': 'Theo(Male)'},
    {'code': 'Heading', 'name': 'German Austria'},
    {'code': 'Lukas', 'name': 'Lukas(Male)'},
    {'code': 'Heading', 'name': 'German Germany'},
    {'code': 'Hanna', 'name': 'Hanna(Female)'},
    {'code': 'Lina', 'name': 'Lina(Female)'},
    {'code': 'Jonas', 'name': 'Jonas(Male)'},
    {'code': 'Heading', 'name': 'German Switzerland'},
    {'code': 'Tim', 'name': 'Tim(Male)'},
    {'code': 'Heading', 'name': 'Greek'},
    {'code': 'Neo', 'name': 'Neo(Male)'},
    {'code': 'Heading', 'name': 'Hebrew'},
    {'code': 'Rami', 'name': 'Rami(Male)'},
    {'code': 'Heading', 'name': 'Hindi'},
    {'code': 'Puja', 'name': 'Puja(Female)'},
    {'code': 'Kabir', 'name': 'Kabir(Male)'},
    {'code': 'Heading', 'name': 'Hungarian'},
    {'code': 'Mate', 'name': 'Mate(Male)'},
    {'code': 'Heading', 'name': 'Indonesian'},
    {'code': 'Intan', 'name': 'Intan(Male)'},
    {'code': 'Heading', 'name': 'Italian'},
    {'code': 'Bria', 'name': 'Bria(Female)'},
    {'code': 'Mia', 'name': 'Mia(Female)'},
    {'code': 'Pietro', 'name': 'Pietro(Male)'},
    {'code': 'Heading', 'name': 'Japanese'},
    {'code': 'Hina', 'name': 'Hina(Female)'},
    {'code': 'Airi', 'name': 'Airi(Female)'},
    {'code': 'Fumi', 'name': 'Fumi(Female)'},
    {'code': 'Akira', 'name': 'Akira(Male)'},
    {'code': 'Heading', 'name': 'Korean'},
    {'code': 'Nari', 'name': 'Nari(Female)'},
    {'code': 'Heading', 'name': 'Malay'},
    {'code': 'Aqil', 'name': 'Aqil(Male)'},
    {'code': 'Heading', 'name': 'Norwegian'},
    {'code': 'Marte', 'name': 'Marte(Female)'},
    {'code': 'Erik', 'name': 'Erik(Male)'},
    {'code': 'Heading', 'name': 'Polish'},
    {'code': 'Julia', 'name': 'Julia(Female)'},
    {'code': 'Jan', 'name': 'Jan(Male)'},
    {'code': 'Heading', 'name': 'Portuguese Brazil'},
    {'code': 'Marcia', 'name': 'Marcia(Female)'},
    {'code': 'Ligia', 'name': 'Ligia(Female)'},
    {'code': 'Yara', 'name': 'Yara(Female)'},
    {'code': 'Dinis', 'name': 'Dinis(Male)'},
    {'code': 'Heading', 'name': 'Portuguese Portugal'},
    {'code': 'Leonor', 'name': 'Leonor(Female)'},
    {'code': 'Heading', 'name': 'Romanian'},
    {'code': 'Doru', 'name': 'Doru(Male)'},
    {'code': 'Heading', 'name': 'Russian'},
    {'code': 'Olga', 'name': 'Olga(Female)'},
    {'code': 'Marina', 'name': 'Marina(Female)'},
    {'code': 'Peter', 'name': 'Peter(Male)'},
    {'code': 'Heading', 'name': 'Slovak'},
    {'code': 'Beda', 'name': 'Beda(Male)'},
    {'code': 'Heading', 'name': 'Slovenian'},
    {'code': 'Vid', 'name': 'Vid(Male)'},
    {'code': 'Heading', 'name': 'Spanish Mexico'},
    {'code': 'Juana', 'name': 'Juana(Female)'},
    {'code': 'Silvia', 'name': 'Silvia(Female)'},
    {'code': 'Teresa', 'name': 'Teresa(Female)'},
    {'code': 'Jose', 'name': 'Jose(Male)'},
    {'code': 'Heading', 'name': 'Spanish Spain'},
    {'code': 'Camila', 'name': 'Camila(Female)'},
    {'code': 'Sofia', 'name': 'Sofia(Female)'},
    {'code': 'Luna', 'name': 'Luna(Female)'},
    {'code': 'Diego', 'name': 'Diego(Male)'},
    {'code': 'Heading', 'name': 'Swedish'},
    {'code': 'Molly', 'name': 'Molly(Female)'},
    {'code': 'Hugo', 'name': 'Hugo(Male)'},
    {'code': 'Heading', 'name': 'Tamil'},
    {'code': 'Sai', 'name': 'Sai(Male)'},
    {'code': 'Heading', 'name': 'Thai'},
    {'code': 'Ukrit', 'name': 'Ukrit(Male)'},
    {'code': 'Heading', 'name': 'Turkish'},
    {'code': 'Omer', 'name': 'Omer(Male)'},
    {'code': 'Heading', 'name': 'Vietnamese'},
    {'code': 'Chi', 'name': 'Chi(Male)'}


];

  Future<void> convertTextToSpeech(String text) async {
    const baseUrl = 'voicerss-text-to-speech.p.rapidapi.com';
    const apiKey = '1c37f955944e415783d029d8d8638ea8'; 
    const apiKeyHeader = '88cf217945mshc4c6d96c099d874p170ff0jsn2b3cba564648'; 

    final params = {
      'key': apiKey,
      'src': text,
      'hl': selectedLanguageCode,
      'r': '1',
      'c': 'mp3',
      'f': '8khz_8bit_mono',
      'v': selectedvoicecode,
    };

    final url = Uri.https(baseUrl, '', params);

    final headers = {
      'X-RapidAPI-Key': apiKeyHeader,
      'X-RapidAPI-Host': 'voicerss-text-to-speech.p.rapidapi.com',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200)  {
        setState(() {
          audioData = response.bodyBytes;
          isAudioAvailable = true;
          // ignore: avoid_print
          print('text to speech done. Status Code: ${response.statusCode}');
        });
        // Save audio data to a file
        final file = await _saveAudioToFile(audioData!);

        // Set the audio source to the file path
        await player.setFilePath(file.path);
      } else {
        // ignore: avoid_print
        print('Failed to convert text to speech. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      // ignore: avoid_print
      print('An error occurred: $error');
    }
  }
  Future<File> _saveAudioToFile(Uint8List data) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/text_to_speech.mp3';

    final file = File(filePath);
    await file.writeAsBytes(data);

    return file;
  }

void audioplayer() async {
  if (audioData != null) {
    try {
      // Save audio data to a file
      final file = await _saveAudioToFile(audioData!);

      // Set the audio source to the file path
      await player.setFilePath(file.path);

     player.play();
    } catch (e) {
      print('Error playing the audio: $e');
    }
  }
}

 void downloadAudio() async {
  if (audioData != null) {
    try {
      final directory = await DownloadsPathProvider.downloadsDirectory;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${directory?.path}/text_to_speech_$timestamp.mp3';

      final file = File(filePath);
      await file.writeAsBytes(audioData!);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Audio downloaded as text_to_speech_$timestamp.mp3 in Downloads folder')),
      );
    } catch (e) {
      // ignore: avoid_print
      print('Error writing the file: $e');
    }
  }
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
            DropdownButton<String>(
              value: selectedvoicecode,
              onChanged: (String? newValue) {
                setState(() {
                  selectedvoicecode = newValue!;
                });
              },
              items: supportedvoice.map<DropdownMenuItem<String>>((Map<String, String> voice) {
                // Check if the name ends with ')'
                bool isNormalFontWeight = voice['name']!.endsWith(')');
                return DropdownMenuItem<String>(
                  
                  value: voice['code'],
                     // Make items with bold font weight unselectable
                 enabled: isNormalFontWeight,
                  child: Text(
                    voice['name']!,
                    // Apply font weight conditionally
                   style: TextStyle(fontWeight: isNormalFontWeight ? FontWeight.normal : FontWeight.bold),
                    ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
               DropdownButton<String>(
              value: selectedLanguageCode,
              onChanged: (String? newValue) {
                setState(() {
                  selectedLanguageCode = newValue!;
                });
              },
              items: supportedLanguages.map<DropdownMenuItem<String>>((Map<String, String> language) {
                return DropdownMenuItem<String>(
                  value: language['code'],
                  child: Text(language['name']!),
                );
              }).toList(),
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
