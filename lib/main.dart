import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gfm_auth/firebase/customer_data_calls.dart';
import 'package:gfm_auth/screens/phone_auth_screen.dart';

import 'package:provider/provider.dart';

import 'firebase/fetching_calls.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => FetchingCalls()),
    ChangeNotifierProvider(create: (context) => CustomerDataCalls()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'PhoneAuthScreen',
        routes: {
          'PhoneAuthScreen': (ctx) => PhoneAuthScreen(),
        });
  }
}
