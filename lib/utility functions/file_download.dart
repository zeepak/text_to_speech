// file_operations.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tts/constant/color.dart';

class FileOperations {
  static Future<void> downloadAudio(String _selectedcodec ,String filename,Uint8List audioData, BuildContext context) async {
    try {
      final directory = await DownloadsPathProvider.downloadsDirectory;
      final filePath = '${directory?.path}/$filename.$_selectedcodec';

      final file = File(filePath);
      await file.writeAsBytes(audioData);
       Fluttertoast.showToast(
            backgroundColor: black_900,
            textColor: white,
            msg: 'Downloaded Successful',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
          );
      
    // ignore: empty_catches
    } catch (e) {
    }
    }
}
