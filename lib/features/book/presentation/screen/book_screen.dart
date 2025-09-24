import 'dart:ui';

import 'package:bazargan/core/constants/colors.dart';
import 'package:bazargan/core/constants/images.dart';
import 'package:flutter/material.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 200 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (_scrollController.offset <= 200 && _isScrolled) {
        setState(() => _isScrolled = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        shape: LinearBorder.bottom(side: BorderSide(color: Colors.transparent)),
        flexibleSpace: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          color: _isScrolled ? Colors.white : Colors.transparent,
        ),
        title: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 400),
          style: TextStyle(
            color: _isScrolled ? Colors.black : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: 'IRANYekanX',
          ),
          child: const Text("صفحه جستجو"),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: Image.asset(Images.listImg, fit: BoxFit.cover),
                        ),
                        Container(
                          color: AppColors.white.withValues(alpha: 0.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
            Card(child: ListTile(title: Text("آیتم شماره"))),
          ],
        ),
      ),
    );
  }
}
