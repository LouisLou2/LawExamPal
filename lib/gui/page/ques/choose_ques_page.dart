import 'package:flutter/cupertino.dart';

class ChooseQuesPage extends StatelessWidget {
  const ChooseQuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
      ),
      children: const [
        Text('1'),
        Text('2'),
        Text('3'),
        Text('4'),
      ],
    );
  }
}