import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfm_auth/firebase/customer_data_calls.dart';
import 'package:gfm_auth/firebase/fetching_calls.dart';
import 'package:gfm_auth/screens/phone_auth_screen.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool? get;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setUp();

    checkSubscription();
    setIntroScreenCheck();
  }

  checkSubscription() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // bool subscribed = preferences.getBool("subscri")
  }

  setIntroScreenCheck() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("firstRun", false);

    get = preferences.getBool("firstRun");
    var fetchingCalls = Provider.of<FetchingCalls>(context, listen: false);

    if (fetchingCalls.firstRun) {
      await fetchingCalls.checkLocationPermission();

      fetchingCalls.firstRun = false;
    } else {
      print("not first run");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerDataCalls>(
      builder: (context, customerDataCalls, child) => Scaffold(
        backgroundColor: Colors.deepOrangeAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(customerDataCalls.customer.email),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () async {
                    await customerDataCalls.signOutFromGoogle();

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhoneAuthScreen()),
                        (route) => false);
                  },
                  child: Icon(
                    Icons.logout_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
