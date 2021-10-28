import 'package:flutter/material.dart';

class ThemedTealButton extends StatelessWidget {
  final Function onTap;
  final buttonLabel;
  final screenSize;
  final icon;

  const ThemedTealButton(
      {Key? key, required this.onTap, this.buttonLabel, this.screenSize, this.icon})
      : super(key: key);

  void functionCallBack() {
    onTap();
  }

  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: functionCallBack,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            buttonLabel,
            style: TextStyle(
              fontSize: 0.024 * screenSize.height,
            ),
          ),
          SizedBox(
            width: 0.01 * screenSize.width,
          ),
          icon != null ? Icon(icon) : Container()
        ],
      ),
      color: Color(0xff00F9B4),
      splashColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
