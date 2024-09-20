import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  const PageTemplate({required this.pageTitle, required this.body, super.key});
  final String pageTitle;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pageTitle), centerTitle: true),
      body: body,
    );
  }
}
