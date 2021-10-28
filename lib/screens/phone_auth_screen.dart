import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gfm_auth/widgets/authentication_header.dart';
import 'package:gfm_auth/widgets/themed_teal_button.dart';

import 'package:provider/provider.dart';

import 'otp_verification.dart';

class PhoneAuthScreen extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 0.2 * screenSize.height,
            ),
            Container(
              margin: EdgeInsetsDirectional.fromSTEB(
                  0.03 * screenSize.width, 0, 0, 0),
              child: AuthenticationHeader(
                screenSize: screenSize,
                header: "Enter your phone No",
                subText:
                    "You will receive a 6 digit code for phone number verification.",
              ),
            ),
            SizedBox(
              height: 0.03 * screenSize.height,
            ),
            Center(
              child: Container(
                height: 0.08 * screenSize.height,
                width: 0.9 * screenSize.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(
                            0.03 * screenSize.width, 0, 0, 0),
                        child: Text(
                          "+91",
                          style: TextStyle(
                              fontSize: 0.025 * screenSize.height,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        endIndent: 0.02 * screenSize.height,
                        indent: 0.02 * screenSize.height,
                        thickness: 0.01 * screenSize.width,
                      ),
                      SizedBox(
                        width: 0.01 * screenSize.width,
                      ),
                      Center(
                        child: Container(
                          width: 0.55 * screenSize.width,
                          child: TextFormField(
                            onChanged: (value) {
                              phoneNumber = value;
                            },
                            validator: (value) {
                              if (value!.length < 10) {
                                print("error");
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            style:
                                TextStyle(fontSize: 0.025 * screenSize.height),
                            decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                hintText: "phone number"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.02 * screenSize.height,
            ),
            Center(
              child: Container(
                  height: 0.06 * screenSize.height,
                  width: 0.5 * screenSize.width,
                  child: ThemedTealButton(
                    screenSize: screenSize,
                    icon: Icons.arrow_forward_outlined,
                    buttonLabel: "Continue",
                    onTap: () {
                      if (phoneNumber.length == 10) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpVerificationScreen(
                              phoneNumber: phoneNumber,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            behavior: SnackBarBehavior.floating,
                            content:
                                Text("Please enter a valid Phone Number")));
                      }
                    },
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
