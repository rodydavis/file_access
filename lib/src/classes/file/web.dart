import 'dart:convert';

import 'impl.dart';

class FileX extends FileXBase {
  final String path;
  final List<int> _bytes;
  Encoding _encoding = utf8;

  FileX(this.path, {List<int> bytes = const []})
      : _bytes = bytes,
        super(path);

  @override
  Future<FileX> writeAsBytes(List<int> data) {
    return Future.value(FileX(path, bytes: data));
  }

  @override
  Future<FileX> writeAsString(String data, {Encoding encoding}) {
    List<int> _data;
    _encoding = encoding ?? utf8;
    _data = _encoding.encode(data);
    return writeAsBytes(_data);
  }

  @override
  Future<List<int>> readAsBytes() async {
    return _bytes;
  }

  @override
  Future<String> readAsString() async {
    return _encoding.decode(_bytes);
  }
}
