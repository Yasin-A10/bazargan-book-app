import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:epub_view/epub_view.dart';
import 'package:internet_file/internet_file.dart';

class EpubViewerScreen extends StatefulWidget {
  final String epubUrl;

  const EpubViewerScreen({super.key, required this.epubUrl});

  @override
  State<EpubViewerScreen> createState() => _EpubViewerScreenState();
}

class _EpubViewerScreenState extends State<EpubViewerScreen> {
  EpubController? _epubController;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadEpub();
  }

  Future<void> _loadEpub() async {
    try {
      final Uint8List bytes = await InternetFile.get(widget.epubUrl);
      final document = EpubDocument.openData(bytes);

      setState(() {
        _epubController = EpubController(document: document);
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _epubController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text('در حال بارگذاری کتاب...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('خطا')),
        body: Center(child: Text('خطا در باز کردن کتاب:\n$_error')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: EpubViewActualChapter(
          controller: _epubController!,
          builder: (chapter) => Text(
            chapter?.chapter?.Title?.replaceAll('\n', '').trim() ??
                'در حال بارگذاری...',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      body: EpubView(controller: _epubController!),
    );
  }
}
