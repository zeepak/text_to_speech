import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

// // ignore: non_constant_identifier_names
// void PlayAudio(Uint8List audioData) async {
//   final player = AudioPlayer();
//   try {
//     // Save audio data to a file
//     final file = await saveAudioToFile(audioData);

//     // Set the audio source to the file path
//     await player.setFilePath(file.path);

//    player.play();
//   } catch (e) {
//     print('Error playing the audio: $e');
//   }
// }
Future<File> saveAudioToFile(Uint8List data) async {
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/text_to_speech.mp3';

  final file = File(filePath);
  await file.writeAsBytes(data);

  return file;
}
