import 'dart:typed_data';

import 'package:file_access/file_access.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FileX _file;
  bool isImage = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : _file == null ? Text('No File Selected') : _buildFile(_file),
      ),
      persistentFooterButtons: <Widget>[
        IconButton(
          onPressed: () async {
            if (mounted)
              setState(() {
                isImage = false;
                _file = null;
                _loading = true;
              });
            final _newFile = await openFile();
            if (mounted)
              setState(() {
                _file = _newFile;
                _loading = false;
              });
          },
          tooltip: 'Select File',
          icon: Icon(Icons.file_upload),
        ),
        IconButton(
          onPressed: () async {
            if (mounted)
              setState(() {
                _file = null;
                isImage = true;
                _loading = true;
              });
            final _newFile = await pickImage();
            if (mounted)
              setState(() {
                _file = _newFile;
                _loading = false;
              });
          },
          tooltip: 'Select Image',
          icon: Icon(Icons.image),
        ),
        IconButton(
          onPressed: () async {
            if (mounted)
              setState(() {
                _file = null;
                isImage = false;
                _loading = true;
              });
            final _newFile = await pickVideo();
            if (mounted)
              setState(() {
                _file = _newFile;
                _loading = false;
              });
          },
          tooltip: 'Select Video',
          icon: Icon(Icons.video_library),
        ),
      ],
    );
  }

  Widget _buildFile(FileX file) {
    return FutureBuilder<List<int>>(
        future: file.readAsBytes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(file.path);
          }
          if (isImage) {
            final _bytes = Uint8List.fromList(snapshot.data);
            return Image.memory(
              _bytes,
              fit: BoxFit.contain,
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(file.path),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Bytes: ${snapshot.data}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        });
  }
}
