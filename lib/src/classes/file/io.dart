import 'dart:convert';
import 'dart:io';

import 'impl.dart';

class FileX extends FileXBase {
  final String path;
  File _file;

  FileX(this.path)
      : _file = File(path),
        super(path);

  @override
  Future<FileX> writeAsBytes(List<int> data) async {
    if (!_file.existsSync()) {
      _file = await _file.create(recursive: true);
    }
    await _file.writeAsBytes(data);
    return FileX(path);
  }

  @override
  Future<FileX> writeAsString(String data, {Encoding encoding}) async {
    if (!_file.existsSync()) {
      _file = await _file.create(recursive: true);
    }
    await _file.writeAsString(data, encoding: encoding);
    return FileX(path);
  }

  @override
  Future<List<int>> readAsBytes() {
    return _file.readAsBytes();
  }

  @override
  Future<String> readAsString() {
    return _file.readAsString();
  }
}
