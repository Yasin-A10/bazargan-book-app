import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:bazargan/core/constants/colors.dart';

class PdfDecryptViewerScreen extends StatelessWidget {
  final String filePath;
  final String? bookName;

  const PdfDecryptViewerScreen({
    super.key,
    required this.filePath,
    required this.bookName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          bookName ?? 'نمایش PDF',
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
      body: SfPdfViewer.file(File(filePath)),
    );
  }
}
