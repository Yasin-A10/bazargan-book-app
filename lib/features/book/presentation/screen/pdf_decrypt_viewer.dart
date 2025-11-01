// import 'dart:io';

// import 'package:bazargan/core/utils/dycrypt.dart';
// import 'package:bazargan/features/book/presentation/bloc/book_file/book_file_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:bazargan/core/constants/colors.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:bazargan/features/book/data/repository/book_file_repository_impl.dart';
// import 'package:bazargan/features/book/data/source/book_file_api_provider.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PdfDecryptViewerScreen extends StatelessWidget {
//   final int bookId;

//   const PdfDecryptViewerScreen({super.key, required this.bookId});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<BookFileBloc>(
//       create: (context) => BookFileBloc(
//         bookFileRepository: BookFileRepositoryImpl(
//           apiProvider: BookFileApiProvider(),
//         ),
//       )..add(LoadBookFileEvent(bookId: bookId)), // Load on creation.
//       child: Scaffold(
//         backgroundColor: AppColors.white,
//         appBar: AppBar(
//           backgroundColor: AppColors.primary,
//           title: const Text(
//             'نمایش PDF',
//             style: TextStyle(color: AppColors.white),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//             icon: const Icon(
//               Iconsax.arrow_right_1_copy,
//               size: 28,
//               color: AppColors.white,
//             ),
//             onPressed: () => context.pop(),
//           ),
//         ),
//         body: BlocBuilder<BookFileBloc, BookFileState>(
//           builder: (context, state) {
//             if (state is BookFileLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is BookFileError) {
//               return Center(child: Text(state.error));
//             } else if (state is BookFileLoaded) {
//               _decryptFile(state.file);
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }

//   Future<SfPdfViewer> _decryptFile(dynamic file) async {
//     final decryptedResult = await decryptFile(
//       file.toString(),
//       'k*KXM09l%RhPF99d',
//     );
//     final decryptedFilePath = 'ffff_decrypted.bin';
//     var decryptedFile = await File(
//       decryptedFilePath,
//     ).writeAsBytes(decryptedResult);
//     return SfPdfViewer.file(
//       decryptedFile,
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:bazargan/core/constants/colors.dart';

class PdfDecryptViewerScreen extends StatelessWidget {
  final String filePath;

  const PdfDecryptViewerScreen({super.key, required this.filePath});

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
      body: SfPdfViewer.file(File(filePath)),
    );
  }
}
