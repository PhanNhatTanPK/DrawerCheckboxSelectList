import 'package:flutter/material.dart';

class Components extends StatelessWidget {
  const Components({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Component Page"),
        centerTitle: true,
      ),
    );
  }
}
