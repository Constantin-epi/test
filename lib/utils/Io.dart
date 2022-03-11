import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _fileToken async {
  final path = await _localPath;
  return File(path + '/token.txt');
}

Future<File> writeToken(String data) async {
  final file = await _fileToken;
  return file.writeAsString(data);
}

Future<String> readToken() async {
  try {
    final file = await _fileToken;
    final contents = await file.readAsString();

    return contents;
  } catch (e) {
    print(e);
    return "";
  }
}