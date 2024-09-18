import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  final String pageTitle;
  final Widget body;

  const PageTemplate({super.key, required this.pageTitle, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pageTitle), centerTitle: true),
      body: body,
    );
  }
}
