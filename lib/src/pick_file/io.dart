import 'package:file_access/file_access.dart';
// import 'package:file_access/src/constants.dart';
// import 'package:file_chooser/file_chooser.dart';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

Future<FileX> openFile() async {
  final _files = await _open(false, false);
  if (_files == null) return null;
  return _files.first;
}

Future<List<FileX>> openFiles() async {
  final _files = await _open(true, false);
  if (_files == null) return null;
  return _files;
}

Future<FileX> pickImage() async {
  if (Platform.isIOS || Platform.isAndroid) {
    var selection = await ImagePicker.pickImage(source: ImageSource.gallery);
    return _add(selection);
  }
  // final _files = await _open(false, false, allowedTypes: [
  //   FileTypeFilterGroup(
  //     label: 'image',
  //     fileExtensions: kImageExtensions,
  //   ),
  // ]);
  // if (_files == null || _files.isEmpty) return null;
  // return _files.first;
  return null;
}

Future<FileX> pickVideo() async {
  if (Platform.isIOS || Platform.isAndroid) {
    var selection = await ImagePicker.pickVideo(source: ImageSource.gallery);
    return _add(selection);
  }
  // final _files = await _open(false, false, allowedTypes: [
  //   FileTypeFilterGroup(
  //     label: 'video',
  //     fileExtensions: kVideoExtensions,
  //   ),
  // ]);
  // if (_files == null || _files.isEmpty) return null;
  // return _files.first;
  return null;
}

Future<List<FileX>> _open(
  bool multiple,
  bool folders,
) async {
  // if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
  //   final results = await showOpenPanel(
  //     allowedFileTypes: allowedTypes,
  //     canSelectDirectories: folders,
  //     allowsMultipleSelection: multiple,
  //   );
  //   if (results.canceled) return null;
  //   final List<FileX> _files = [];
  //   for (final item in results.paths) {
  //     _files.add(await _add(File(item)));
  //   }
  //   return _files;
  // }
  if (Platform.isIOS || Platform.isAndroid) {
    final List<FileX> _files = [];
    if (multiple) {
      List<File> files = await FilePicker.getMultiFile();
      if (files == null) return null;
      for (final file in files) {
        _files.add(await _add(file));
      }
    } else {
      File file = await FilePicker.getFile();
      if (file == null) return null;
      _files.add(await _add(file));
    }
    return _files;
  }
  return null;
}

Future<FileX> _add(File file) async {
  try {
    final _base = FileX(file.path);
    final _bytes = await file.readAsBytes();
    return await _base.writeAsBytes(_bytes);
  } catch (e) {}
  return null;
}
