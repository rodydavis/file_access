import 'dart:convert';

abstract class FileXBase {
  final String path;

  FileXBase(this.path);

  Future<FileXBase> writeAsBytes(List<int> data);

  Future<FileXBase> writeAsString(String data, {Encoding encoding});

  Future<List<int>> readAsBytes();

  Future<String> readAsString();
}
