import 'package:flutter/material.dart';

class EmptyChatWidget extends StatelessWidget {
  const EmptyChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Ask Something!',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}