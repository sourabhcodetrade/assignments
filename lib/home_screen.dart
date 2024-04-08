
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red),
              ),
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles();
                if (result != null) {
                   file = result.files.single.path ;
                  print('file path = $file');
                } else {

                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PDFViewerFromLocalFile(
                            path: file,
                          )),
                );
              },
              child: const Text(
                'Local PDF',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PDFViewerCachedFromUrl(
                          url: 'https://gbihr.org/images/docs/test.pdf')),
                );
              },
              child: const Text(
                'Network PDF',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PDFViewerFromAssets(
                          path: 'assets/pdf/example.pdf')),
                );
              },
              child: const Text(
                'Assets PDF',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          'PDF From URL',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const PDF().cachedFromUrl(
        url,
        placeholder: (progress) => Center(
          child: Text('Progress $progress'),
        ),
        errorWidget: (error) => Center(
          child: Text('Error $error'),
        ),
      ),
    );
  }
}

class PDFViewerFromAssets extends StatelessWidget {
  const PDFViewerFromAssets({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'PDF From Assets',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const PDF(
        autoSpacing: true,
        pageSnap: true,
      ).fromAsset(
        path,
        loadingWidget: () => const CircularProgressIndicator(),
        errorWidget: (error) => Center(
          child: Text('Error $error'),
        ),
      ),
    );
  }
}

class PDFViewerFromLocalFile extends StatelessWidget {
  const PDFViewerFromLocalFile({super.key, required this.path});

  final String? path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          'PDF From URL',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const PDF(
        autoSpacing: true,
        pageSnap: true,
      ).fromPath(
        path!,
      ),
    );
  }
}
