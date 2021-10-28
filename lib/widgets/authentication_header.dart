import 'package:flutter/material.dart';

class AuthenticationHeader extends StatelessWidget {
  final screenSize;
  final header;
  final subText;
  final screenName;
  final backBtn;
  final headerSmall;

  const AuthenticationHeader({
    Key? key,
    this.screenSize,
    this.header,
    this.subText,
    this.screenName,
    this.backBtn = false,
    this.headerSmall = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 0.7 * screenSize.width,
              child: Row(
                children: [
                  backBtn
                      ? IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back))
                      : SizedBox(),
                  Expanded(
                    child: Text(
                      header,
                      style: !headerSmall
                          ? TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 0.055 * screenSize.height)
                          : TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 0.035 * screenSize.height),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 0.01 * screenSize.height,
            ),
            Container(
              margin: EdgeInsetsDirectional.fromSTEB(
                  0.0 * screenSize.width, 0, 0, 0),
              width: 0.7 * screenSize.width,
              child: Text(
                subText ?? "",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 0.02 * screenSize.height),
              ),
            ),
            screenSize == "cart" || screenSize == "checkOut"
                ? Column(
                    children: [
                      SizedBox(height: 0.01 * screenSize.height),
                      Container(
                        width: 0.6 * screenSize.width,
                        child: Text(
                          subText,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 0.02 * screenSize.height),
                        ),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ],
    );
  }
}
