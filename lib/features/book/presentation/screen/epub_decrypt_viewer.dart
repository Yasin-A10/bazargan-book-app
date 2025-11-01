import 'dart:io';
import 'package:flutter/material.dart';
import 'package:epub_view/epub_view.dart';

class EpubDecryptViewerScreen extends StatefulWidget {
  final String filePath; // فقط مسیر فایل محلی

  const EpubDecryptViewerScreen({super.key, required this.filePath});

  @override
  State<EpubDecryptViewerScreen> createState() =>
      _EpubDecryptViewerScreenState();
}

class _EpubDecryptViewerScreenState extends State<EpubDecryptViewerScreen> {
  late EpubController _epubController;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadEpub();
  }

  Future<void> _loadEpub() async {
    try {
      // فقط از فایل محلی بخوان
      final bytes = await File(widget.filePath).readAsBytes();
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
    _epubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('خطا')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('خطا در باز کردن کتاب:\n$_error'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: EpubViewActualChapter(
          controller: _epubController,
          builder: (chapter) => Text(
            chapter?.chapter?.Title?.replaceAll('\n', '').trim() ?? 'کتاب',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      body: EpubView(controller: _epubController),
    );
  }
}
