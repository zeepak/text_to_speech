// file_operations.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FileOperations {
  static Future<void> downloadAudio(String filename,Uint8List audioData, BuildContext context) async {
    try {
      final directory = await DownloadsPathProvider.downloadsDirectory;
      final filePath = '${directory?.path}/$filename.mp3';

      final file = File(filePath);
      await file.writeAsBytes(audioData);
       Fluttertoast.showToast(
            msg: 'Downloaded Successful',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
      
    } catch (e) {
      print('Error writing the file: $e');
    }
    }
}
