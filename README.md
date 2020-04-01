# file_access

An abstract way to handle files on iOS, Android, Desktop and Web!

Online Demo: https://rodydavis.github.io/file_access/

Installing: 

```yaml
dependencies:
  flutter:
    sdk: flutter
  file_access:
    git: https://github.com/rodydavis/file_access
```

## Setup

### Web

Add the following line to your body to make it work in Safari:

```html
<input type="file" style="visibility:hidden;" id="file-picker" />
```

### IOS

https://github.com/miguelpruivo/flutter_file_picker/wiki/Setup#ios


## Getting Started

Pick a file:

```dart
final _file = await openFile();

```

Select multiple files:

```dart
final _files = await openFiles();

```

Pick an image:

```dart
final _file = await pickImage();

```

Pick a video:

```dart
final _file = await pickVideo();

```

Once you have the `FileX` type you can read the data:

```dart
final _bytes = await _file.readAsBytes();
final _string = await _file.readAsString();
```

Creating a new file:

```dart
final _file = FileX('path/to/file/file.txt');
await _file.writeAsString('My New Data!');
final _output = await _file.readAsString();
print(_output); // 'My New Data!'
```