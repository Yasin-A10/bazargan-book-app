import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bazargan/core/constants/colors.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  final String? filePath;
  final String? fileUrl;

  const PdfViewerScreen({super.key, this.filePath, this.fileUrl})
    : assert(
        filePath != null || fileUrl != null,
        'Either filePath or fileUrl must be provided',
      ); // for testing

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'نمایش PDF',
          style: TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            size: 28,
            color: AppColors.white,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: filePath != null
          ? SfPdfViewer.file(File(filePath!)) // from local file
          : SfPdfViewer.network(fileUrl!), // from url
    );
  }
}
