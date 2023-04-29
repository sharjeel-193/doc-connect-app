import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class PatientRecordsScreen extends StatefulWidget {
  @override
  _PatientRecordsScreenState createState() => _PatientRecordsScreenState();
}

class _PatientRecordsScreenState extends State<PatientRecordsScreen> {
  List<File> _files = [];

  void _uploadFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _files.addAll(result.files.map((file) => File(file.path!)).toList());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _files.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_files[index].path),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Upload File'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text('Select File'),
                      onPressed: () {
                        if (Platform.isAndroid ||
                            Platform.isIOS ||
                            Platform.isMacOS) {
                          _uploadFile();
                        } else if (Platform.isWindows || Platform.isLinux) {
                          // show file picker dialog for desktop platforms
                        }
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter file name',
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    child: Text('Upload'),
                    onPressed: () {
                      // upload file logic
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
