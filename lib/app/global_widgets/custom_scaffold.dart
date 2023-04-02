import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final List<Widget> slivers;
  final String title;
  const CustomScaffold(this.slivers, {super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: slivers,
        ),
      ),
    );
  }
}
