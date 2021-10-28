import 'package:flutter/material.dart';

class TextScreen extends StatelessWidget {
  const TextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: const [
      Text(
        "GO",
        style: TextStyle(
          fontSize: 36,
          color: Colors.white,
          // fontWeight: FontWeight.bold,
          fontFamily: 'Modeco',
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        " FOOD",
        style: TextStyle(
            fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      Text(
        " MAN",
        style: TextStyle(
            fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
