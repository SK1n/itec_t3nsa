import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final List<Widget> slivers;
  final String title;
  final Widget? trailing;
  const CustomScaffold(this.slivers,
      {super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [trailing ?? const SizedBox.shrink()],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: slivers,
        ),
      ),
    );
  }
}
