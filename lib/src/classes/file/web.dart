import 'dart:convert';
import 'dart:html';

import 'impl.dart';

class FileX extends FileXBase {
  final String path;
  final File _file;

  FileX(this.path, {List<int> bytes = const []})
      : _file = File(bytes, path),
        super(path);

  @override
  Future<FileX> writeAsBytes(List<int> data) {
    return Future.value(FileX(path, bytes: data));
  }

  @override
  Future<FileX> writeAsString(String data, {Encoding encoding}) {
    List<int> _data;
    if (encoding != null) {
      _data = encoding.encode(data);
    } else {
      _data = utf8.encode(data);
    }
    return writeAsBytes(_data);
  }

  @override
  Future<List<int>> readAsBytes() async {
    final reader = new FileReader();
    reader.readAsArrayBuffer(_file);
    await reader.onLoadEnd.first;
    return reader.result as List<int>;
  }

  @override
  Future<String> readAsString() async {
    final reader = new FileReader();
    reader.readAsText(_file);
    await reader.onLoadEnd.first;
    return reader.result;
  }
}
