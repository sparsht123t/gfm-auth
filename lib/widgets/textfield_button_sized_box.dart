import 'package:flutter/material.dart';

class TextFieldButtonSizedBox extends StatelessWidget {
  final screenSize;
  const TextFieldButtonSizedBox({Key? key, this.screenSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 0.012 * screenSize.height,);
  }
}
