// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'btn.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Btn(),
            Btn(
              callback: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result != null) {
                  File file = File(result.files.single.path!);
                } else {}
              },
              text: 'Pick Single File',
            ),
            Btn(
              callback: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(allowMultiple: true);
                if (result != null) {
                  List<File> files =
                      result.paths.map((path) => File(path!)).toList();
                } else {}
              },
              text: 'Pick Multiple File',
            ),
            Btn(
              callback: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['jpg']);
                if (result != null) {
                  File file = File(result.files.single.path!);
                } else {}
              },
              text: 'Pick JPG File',
            ),
            Btn(
              callback: () async {
                String? path = await FilePicker.platform.getDirectoryPath(
                  dialogTitle: 'Pick a directory',
                );
                if (path != null) {
                } else {}
              },
              text: 'Select Directory',
            ),
          ],
        ),
      ),
    );
  }
}
