import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PathScreen extends StatefulWidget {
  const PathScreen({super.key});

  @override
  State<PathScreen> createState() => _PathScreenState();
}

class _PathScreenState extends State<PathScreen> {
  Directory? _tempDirectory;
  Directory? _appSupportDirectory;
  Directory? _appLibraryDirectory;
  Directory? _appDocumentsDirectory;
  Directory? _appCacheDirectory;
  Directory? _externalDocumentsDirectory;
  List<Directory>? _externalStorageDirectories;
  List<Directory>? _externalCacheDirectories;
  Directory? _downloadsDirectory;

  Widget _buildDirectory(Directory? directory) {
    Text text = const Text('');

    if (directory != null) {
      text = Text('path: ${directory.path}');
    } else {
      text = const Text('path unavailable');
    }

    return Padding(padding: const EdgeInsets.all(16.0), child: text);
  }

  Widget buildDirectories(List<Directory?>? directories) {
    final String combined =
        directories?.map((d) => d!.path).join(', ') ?? 'unavailable';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('paths: $combined'),
    );
  }

  void _requestTempDirectory() async {
    _tempDirectory = await getTemporaryDirectory();

    setState(() {});
  }

  void _requestAppDocumentsDirectory() async {
    _appDocumentsDirectory = await getApplicationDocumentsDirectory();
    setState(() {});
  }

  void _requestAppSupportDirectory() async {
    _appSupportDirectory = await getApplicationSupportDirectory();
    setState(() {});
  }

  void _requestAppLibraryDirectory() async {
    _appLibraryDirectory = await getLibraryDirectory();
    setState(() {});
  }

  void _requestAppCacheDirectory() async {
    _appCacheDirectory = await getApplicationCacheDirectory();
    setState(() {});
  }

  void _requestExternalStorageDirectory() async {
    _externalDocumentsDirectory = await getExternalStorageDirectory();
    setState(() {});
  }

  void _requestExternalStorageDirectories(StorageDirectory type) async {
    _externalStorageDirectories =
        await getExternalStorageDirectories(type: type);
    setState(() {});
  }

  void _requestExternalCacheDirectories() async {
    _externalCacheDirectories = await getExternalCacheDirectories();
    setState(() {});
  }

  void _requestDownloadsDirectory() async {
    _downloadsDirectory = await getDownloadsDirectory();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _requestTempDirectory,
                    child: const Text(
                      'Get Temporary Directory',
                    ),
                  ),
                ),
                _buildDirectory(_tempDirectory),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _requestAppDocumentsDirectory,
                    child: const Text(
                      'Get Application Documents Directory',
                    ),
                  ),
                ),
                _buildDirectory(_appDocumentsDirectory),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _requestAppSupportDirectory,
                    child: const Text(
                      'Get Application Support Directory',
                    ),
                  ),
                ),
                _buildDirectory(_appSupportDirectory),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed:
                        Platform.isAndroid ? null : _requestAppLibraryDirectory,
                    child: Text(
                      Platform.isAndroid
                          ? 'Application Library Directory unavailable'
                          : 'Get Application Library Directory',
                    ),
                  ),
                ),
                _buildDirectory(_appLibraryDirectory),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _requestAppCacheDirectory,
                    child: const Text(
                      'Get Application Cache Directory',
                    ),
                  ),
                ),
                _buildDirectory(_appCacheDirectory),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: !Platform.isAndroid
                        ? null
                        : _requestExternalStorageDirectory,
                    child: Text(
                      !Platform.isAndroid
                          ? 'External storage is unavailable'
                          : 'Get External Storage Directory',
                    ),
                  ),
                ),
                _buildDirectory(_externalDocumentsDirectory),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: !Platform.isAndroid
                        ? null
                        : () {
                            _requestExternalStorageDirectories(
                              StorageDirectory.music,
                            );
                          },
                    child: Text(
                      !Platform.isAndroid
                          ? 'External directories are unavailable'
                          : 'Get External Storage Directories',
                    ),
                  ),
                ),
                buildDirectories(_externalStorageDirectories),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: !Platform.isAndroid
                        ? null
                        : _requestExternalCacheDirectories,
                    child: Text(
                      !Platform.isAndroid
                          ? 'External directories are unavailable'
                          : 'Get External Cache Directories',
                    ),
                  ),
                ),
                buildDirectories(_externalCacheDirectories),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: Platform.isAndroid || Platform.isIOS
                        ? null
                        : _requestDownloadsDirectory,
                    child: Text(
                      Platform.isAndroid || Platform.isIOS
                          ? 'Downloads directory is unavailable'
                          : 'Get Downloads Directory',
                    ),
                  ),
                ),
                Platform.isAndroid || Platform.isIOS
                    ? _buildDirectory(_downloadsDirectory)
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
