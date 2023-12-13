import 'package:flutter/material.dart';

class MessageDetailBackground extends StatelessWidget {
  const MessageDetailBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(),
    );
  }
}
