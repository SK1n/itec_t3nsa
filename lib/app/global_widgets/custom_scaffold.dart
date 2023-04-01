import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomScaffold extends StatelessWidget {
  final List<Widget> slivers;
  const CustomScaffold(this.slivers, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: slivers,
        ),
      ),
    );
  }
}
