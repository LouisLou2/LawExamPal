import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double heightFraction({double fraction = 1}) =>
      MediaQuery.sizeOf(this).height * fraction;

  double widthFraction({double fraction = 1}) =>
      MediaQuery.sizeOf(this).width * fraction;
}