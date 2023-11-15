// file_operations.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';

class FileOperations {
  static Future<void> downloadAudio(Uint8List audioData, BuildContext context) async {
    if (audioData != null) {
      try {
        final directory = await DownloadsPathProvider.downloadsDirectory;
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final filePath = '${directory?.path}/text_to_speech_$timestamp.mp3';

        final file = File(filePath);
        await file.writeAsBytes(audioData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Audio downloaded as text_to_speech_$timestamp.mp3 in Downloads folder')),
        );
      } catch (e) {
        print('Error writing the file: $e');
      }
    }
  }
}
