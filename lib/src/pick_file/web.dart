import 'dart:async';

import 'package:file_access/file_access.dart';

import 'dart:html' as html;

Future<FileX> pickImage() async {
  final _files = await _open(false, false, 'image/*');
  if (_files == null || _files.isEmpty) return null;
  return _files.first;
}

Future<FileX> pickVideo() async {
  final _files = await _open(false, false, 'video/*');
  if (_files == null || _files.isEmpty) return null;
  return _files.first;
}

Future<FileX> pickAudio() async {
  final _files = await _open(false, false, 'audio/*');
  if (_files == null || _files.isEmpty) return null;
  return _files.first;
}

Future<FileX> openFile() async {
  final _files = await _open(false, false);
  if (_files == null || _files.isEmpty) return null;
  return _files.first;
}

Future<List<FileX>> openFiles() async {
  final _files = await _open(true, false);
  if (_files == null) return null;
  return _files;
}

Future<List<FileX>> _open(bool multiple, bool folders,
    [String types = '*']) async {
  final _upload = html.FileUploadInputElement();
  _upload.accept = types;
  _upload.multiple = multiple;
  if (folders) {
    _upload.setAttribute('webkitdirectory', '');
    _upload.setAttribute('mozdirectory', '');
  }
  _upload.click();
  final _file = await _upload.onChange.first;
  if (_file == null) return null;
  List<html.File> files = (_file.target as dynamic).files;
  final List<FileX> _files = [];
  for (final f in files) {
    try {
      final _path = folders ? f.relativePath : f.name;
      final _base = FileX(_path);
      final reader = new html.FileReader();
      reader.readAsArrayBuffer(f);
      final _loaded = await _listen(reader.onLoad);
      if (!_loaded) continue;
      final _bytes = reader.result as List<int>;
      final _newFile = await _base.writeAsBytes(_bytes);
      _files.add(_newFile);
    } catch (e) {}
  }
  return _files;
}

Future<bool> _listen(Stream<html.ProgressEvent> stream) async {
  try {
    await for (var value in stream) {
      if (value.total == value.loaded) {
        return true;
      }
    }
  } catch (e) {
    return false;
  }

  return false;
}
