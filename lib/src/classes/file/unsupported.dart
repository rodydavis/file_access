import 'dart:convert';

import 'impl.dart';

class FileX extends FileXBase {
  final String path;

  FileX(this.path) : super(path);

  @override
  Future<FileX> writeAsBytes(List<int> data) {
    throw 'Platform Not Supported';
  }

  @override
  Future<FileX> writeAsString(String data, {Encoding encoding}) {
    throw 'Platform Not Supported';
  }

  @override
  Future<List<int>> readAsBytes() {
    throw 'Platform Not Supported';
  }

  @override
  Future<String> readAsString() {
    throw 'Platform Not Supported';
  }
}
