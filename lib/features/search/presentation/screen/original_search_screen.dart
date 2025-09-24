import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class OriginalSearchScreen extends StatefulWidget {
  const OriginalSearchScreen({super.key});

  @override
  State<OriginalSearchScreen> createState() => _OriginalSearchScreenState();
}

class _OriginalSearchScreenState extends State<OriginalSearchScreen> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("جستجو"),
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_right_1_copy,
            color: AppColors.neutral757575,
            size: 16,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: CustomSearchBar(
          hintText: "جستجو در نام کتاب، نویسنده، ناشر و ...",
          focusNode: _focusNode,
          onSearch: (value) {},
        ),
      ),
    );
  }
}
