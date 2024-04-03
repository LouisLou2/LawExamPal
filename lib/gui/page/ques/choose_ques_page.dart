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
        Text('5'),
        Text('6'),
        Text('7'),
        Text('8'),
        Text('9'),
        Text('10'),
        Text('11'),
        Text('12'),
        Text('13'),
        Text('14'),
        Text('15'),
        Text('16'),
      ],
    );
  }
}