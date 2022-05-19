import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileOperations {
  static Future<String> get getRecentsFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get getRecentsFile async {
    final path = await getRecentsFilePath;
    return File('$path/roadmap/recents.txt');
  }

  static Future<File> get getFile async {
    final path = await getRecentsFilePath;
    return File('$path/new.txt');
  }

  static Future<File> saveToFile(String data) async {
    final file = await getRecentsFile;
    return file.writeAsString(data);
  }

  static Future<String> readFromFile({String name="recents"}) async {
    try {

      final file = await getFile;
      String fileContents = await file.readAsString();
      return fileContents;
    } catch (e) {
      return '';
    }
  }
}
