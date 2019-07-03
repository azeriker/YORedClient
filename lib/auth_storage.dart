import 'dart:io';

import 'package:path_provider/path_provider.dart';

class AuthStorage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/auth.txt');
  }

  static Future<String> readAuth() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      return null;
    }
  }

  static Future<File> writeAuth(String token) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$token');
  }

  static Future<File> clearAuth() async {
    final file = await _localFile;

    // Write the file
    return file.delete();
  }
}
