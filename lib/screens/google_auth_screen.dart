import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfm_auth/firebase/customer_data_calls.dart';
import 'package:gfm_auth/firebase/fetching_calls.dart';
import 'package:gfm_auth/screens/homescreen.dart';
import 'package:gfm_auth/widgets/authentication_header.dart';
import 'package:gfm_auth/widgets/cutom_loading_animation.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleAuthScreen extends StatefulWidget {
  const GoogleAuthScreen({Key? key}) : super(key: key);

  @override
  _GoogleAuthScreenState createState() => _GoogleAuthScreenState();
}

class _GoogleAuthScreenState extends State<GoogleAuthScreen> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
//FB and Google logo paths
  List<String> imagePaths = [
    "assets/images/phoneicon.png",
    "assets/images/googlelogo.png",
  ];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Consumer2<CustomerDataCalls, FetchingCalls>(
        builder: (context, customerDataCalls, fetchingCalls, child) =>
            GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: Column(
              children: [
                SizedBox(
                  height: 0.2 * screenSize.height,
                ),
                Container(
                  margin: EdgeInsetsDirectional.fromSTEB(
                      0.03 * screenSize.width, 0, 0, 0),
                  child: Center(
                    child: AuthenticationHeader(
                      header: "Now, All Set",
                      subText: "Just last step for better service",
                      screenSize: screenSize,
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.15 * screenSize.height,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    height: 0.1 * screenSize.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 0.10 * screenSize.height,
                          width: 0.85 * screenSize.width,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 10,
                            color: Color(0xFFECF2F7),
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });

                              await customerDataCalls.signInWithGoogle();

                              if (customerDataCalls.googleSignInAccount !=
                                  null) {
                                if (await customerDataCalls
                                        .customerExistsGoogle(customerDataCalls
                                            .googleSignInAccount!.email) ==
                                    true) {
                                  await customerDataCalls.signOutFromGoogle();

                                  print(
                                      "EMAIL ID ALREADY EXISTS>>>>>>>>>>>>>>>>> PLEASE USE DIFFERENT EMAIL");

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          behavior: SnackBarBehavior.floating,
                                          duration: Duration(seconds: 4),
                                          content: Text(
                                              "user already exists, use different email")));

                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  await customerDataCalls.updateGmail(
                                      customerDataCalls.customer.docId,
                                      customerDataCalls
                                          .googleSignInAccount!.email);
                                          await customerDataCalls.updateName(
                                      customerDataCalls.customer.docId,
                                       customerDataCalls
                                          .googleSignInAccount!.displayName!);

                                  customerDataCalls.customer.email =
                                      customerDataCalls
                                          .googleSignInAccount!.email;

                                  customerDataCalls.customer.name =
                                      customerDataCalls
                                          .googleSignInAccount!.displayName!;

                                  customerDataCalls.customer.photoUrl =
                                      customerDataCalls
                                          .googleSignInAccount!.photoUrl!;

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Homescreen()),
                                      (route) => false);
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    height: 0.05 * screenSize.height,
                                    child: Image.asset(
                                      imagePaths[1],
                                    )),
                                const Text("Log in using your Google Account."),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isLoading
                    ? CustomLoadingAnimation(
                        screenSize: screenSize,
                      )
                    : Container(),
                SizedBox(
                  height: 0.02 * screenSize.height,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
