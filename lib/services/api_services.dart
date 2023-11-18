import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:tts/constant/color.dart';
import 'package:tts/utility%20functions/audio_player.dart';

class TextToSpeechService {
  static Future<void> convertTextToSpeech({
    required String text,
    required String selectedcodec,
    required String selectedLanguageCode,
    required String selectedVoiceCode,
    required String selectedspeed,
    required String selectedformat,
    required AudioPlayer player,
    required Function(Uint8List) onAudioAvailable,
    required Function(String) onError,
  }) async {
    const baseUrl = 'voicerss-text-to-speech.p.rapidapi.com';
    const apiKey = '1c37f955944e415783d029d8d8638ea8';
    const apiKeyHeader = '88cf217945mshc4c6d96c099d874p170ff0jsn2b3cba564648';

    final params = {
      'key': apiKey,
      'src': text,
      'hl': selectedLanguageCode,
      'r': selectedspeed,
      'c': selectedcodec,
      'f': selectedformat,
      'v': selectedVoiceCode,
    };

    final url = Uri.https(baseUrl, '', params);

    final headers = {
      'X-RapidAPI-Key': apiKeyHeader,
      'X-RapidAPI-Host': 'voicerss-text-to-speech.p.rapidapi.com',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
       
        final audioData = response.bodyBytes;

        onAudioAvailable(audioData);

        // Save audio data to a file
        final file = await saveAudioToFile(audioData);

        // Set the audio source to the file path
        await player.setSourceDeviceFile(file.path);
        
        Fluttertoast.showToast(
            backgroundColor: black_900,
            textColor: white,
            msg: 'Conversion Successful',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
          
            
      } else {
        Fluttertoast.showToast(
          backgroundColor: black_900,
            textColor: white,
            msg: 'Conversion Failed',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
        onError('Failed to convert text to speech. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      onError('An error occurred: $error');
    }
  }
}
