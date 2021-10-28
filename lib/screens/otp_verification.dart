import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gfm_auth/firebase/customer_data_calls.dart';
import 'package:gfm_auth/firebase/fetching_calls.dart';
import 'package:gfm_auth/screens/homescreen.dart';

import 'package:gfm_auth/widgets/authentication_header.dart';
import 'package:gfm_auth/widgets/cutom_loading_animation.dart';
import 'package:gfm_auth/widgets/themed_teal_button.dart';

import 'package:provider/provider.dart';

import 'package:introduction_screen/introduction_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'google_auth_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final phoneNumber;

  const OtpVerificationScreen({Key? key, this.phoneNumber}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String otp = "";
  String verificationId = "";
  //verificationId is the id that we receive while verifying the phone number.
  bool isLoading = false;

  void initState() {
    super.initState();
    otpVerification(false); // false:first time otp
  }

  Future<void> otpVerification(bool resend) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+91${widget.phoneNumber}',
      verificationCompleted: (AuthCredential Credential) async {
   
        await FirebaseAuth.instance
            .signInWithCredential(Credential)
            .then((value) async {
          if (value.user != null) {
            
            print(
                '$Credential  Credential coming from ------- verificationCompleted:');
            print('$value  value coming from ------- verificationCompleted:');
            print(
                '${value.user}  value.user coming from ------- verificationCompleted:');

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Homescreen()),
                (route) => false);
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        print(e.message);
      },
      
      codeSent: (String verificationCode, int? forceResendingToken) {
      
        print("OTP SENT");

        if (resend == true) {
          
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
              content: Text("OTP Sent")));
        }
        
        setState(() {
          verificationId = verificationCode;
          print(
              '$verificationId  verificationId coming from ------- CODE SENT:');
        });
      },
      codeAutoRetrievalTimeout: (String verificationCode) {
        if (this.mounted) {
          setState(() {
            verificationId = verificationCode;
            print(
                '$verificationId  verificationId coming from ------- codeAutoRetrievalTimeout:');
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Consumer2<CustomerDataCalls, FetchingCalls>(
          builder: (context, customerDataCalls, fetchingCalls, child) =>
              GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 0.2 * screenSize.height,
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.fromSTEB(
                        0.03 * screenSize.width, 0, 0, 0),
                    child: AuthenticationHeader(
                      screenSize: screenSize,
                      header: "Verification Code",
                      subText:
                          "We have texted you a code. Please enter it below.",
                    ),
                  ),
                  SizedBox(
                    height: 0.02 * screenSize.height,
                  ),
                  Center(
                    child: Container(
                      width: 0.8 * screenSize.width,
                      child: PinCodeTextField(
                        pinTheme: PinTheme(
                            borderRadius: BorderRadius.circular(10),
                            shape: PinCodeFieldShape.box,
                            activeColor: Color(0xff00F9B4),
                            selectedColor: Color(0xff00F9B4),
                            inactiveColor: Colors.red[300]),
                        appContext: context,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        animationType: AnimationType.scale,
                        length: 6,
                        useHapticFeedback: true,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            otp = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.02 * screenSize.height,
                  ),
                  Center(
                    child: Text(
                      "Didn\'t get the code?",
                      style: TextStyle(
                          fontSize: 0.02 * screenSize.height,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 0.01 * screenSize.height,
                  ),
                  Center(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          isLoading = true;
                        });
                        await otpVerification(true);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Text(
                        "Resend",
                        style: TextStyle(
                            fontSize: 0.02 * screenSize.height,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.03 * screenSize.height,
                  ),
                  Center(
                    child: ThemedTealButton(
                        screenSize: screenSize,
                        buttonLabel: "Verify",
                        icon: Icons.check,
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            isLoading = true;
                          });
                        
                          try {
                            await FirebaseAuth.instance
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationId,
                                        smsCode: otp))
                                .then((value) async {
                              print(
                                  '----------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>---------------------------------------------------------');
                              print(
                                  '${value.user} :value.user: coming from FirebaseAuth.instance.signInWithCredential ');
                              print(
                                  '---------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------------------------------------');
                              print(
                                  '$value :value: coming from FirebaseAuth.instance.signInWithCredential ');
                              print(
                                  '---------------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------------------------------------');
                              // if (value.user != null) {
                              // Check that if user already exists in DB?
                              if (await customerDataCalls
                                      .customerExists(widget.phoneNumber) ==
                                  true) {
                                // We can get all the current values of customer

                                print(
                                    '$auth.currentUser  ---------------------  USER EXISTS  -------------------------- auth.currentuser');
                                print(
                                    '$auth.currentUser  ----------------------------------------------- auth.currentuser');

                                await customerDataCalls
                                    .initializeUserData(auth.currentUser!.uid);

                                //Data related to that user is fetched,

                                if (customerDataCalls
                                        .customer.email ==
                                    "") {
                                  print("USER HAD REGISTERED PHONE NUMBER WITHOUT REGISTERING GOOGLE ID");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GoogleAuthScreen()));
                                } else {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Homescreen()),
                                      (route) => false);
                                }

                                // );
                                setState(() {
                                  isLoading = false;
                                });
                               
                              } else {
                                print(
                                    'customerExists===== false ===========================');
                                
                                customerDataCalls.customer.authId =
                                    auth.currentUser!.uid;
                                customerDataCalls.customer.phoneNumber =
                                    "+91${widget.phoneNumber}";
                            

                                customerDataCalls
                                    .createUserDocument(auth.currentUser!.uid);
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GoogleAuthScreen()));
                              }
                              // }
                            });
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            FocusScope.of(context).unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Error occurred. Please try again.')));

                            print(e);
                          }
                        }),
                  ),
                  isLoading
                      ? Center(
                          child: CustomLoadingAnimation(
                            screenSize: screenSize,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
