import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gfm_auth/models/customer.dart';

import 'package:google_sign_in/google_sign_in.dart';

class CustomerDataCalls extends ChangeNotifier {
  CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('Customers');
  CollectionReference foodCollection =
      FirebaseFirestore.instance.collection('Food');
  CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('Restaurants');

  Customer customer = new Customer();
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  User? user; // for gmail login

  //Create new User doc and push it to  Firebase upon signing up
  Future<void> createUserDocument(String authId) async {
    String newUserDocID;
    print(" auth.currentUser!.uid   is \/\/\/          ${authId}");
    final doc = await customerCollection.add({
      'authId': authId,
      'customerCreatedAt': Timestamp.now(),
      'name': customer.name,
      'loginType': customer.loginType,
      'phoneNumber': customer.phoneNumber,
      'location': customer.location,
      'cart': customer.cart,
      'cartRestaurantId': customer.cartRestaurantId,
      'cartQuantity': customer.cartQuantity,
      'wishListFood': customer.wishListFood,
      'wishListRestaurants': customer.wishListRestaurants,
      'orders': customer.orders,
      'email': customer.email,
      'photoUrl': customer.photoUrl,
      'appVersion': customer.appVersion,
      'lastLogin': Timestamp.now()
    });

    print('${doc.id} -.-.-.-.-.-.-.-.-.-. doc.id');
    customer.docId = doc.id;
    await customerCollection
        .doc(customer.docId)
        .update({'docId': customer.docId});
  }

  //Customer exists check
  Future<bool> customerExists(String phoneNumber) async {
    bool customerExists = false;
    await customerCollection
        .where(
          'phoneNumber',
          isEqualTo: '+91$phoneNumber',
        )
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.size > 0) {
        customerExists = true;
      } else {
        customerExists = false;
      }
    });
    return customerExists;
  }

  //Initialize UserData


  initializeUserData(String authId) async {
    await customerCollection
        .where("authId", isEqualTo: authId)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              print(querySnapshot.docs.isEmpty ? "EMPTY DOC" : "Non empty"),
              querySnapshot.docs.forEach((doc) {
                Object? fieldCheck = doc.data();
                customer.authId = doc['authId'];
                customer.docId = doc['docId'];
                customer.email = doc['email'];
                customer.photoUrl = doc['photoUrl'];
                customer.name = doc['name'];
                customer.phoneNumber = doc['phoneNumber'];
                customer.loginType = doc['loginType'];
                customer.cart = doc['cart'];
                customer.cartRestaurantId = doc['cartRestaurantId'];
                customer.cartQuantity = doc['cartQuantity'];
                customer.orders = doc['orders'];
                customer.wishListFood = doc['wishListFood'];
                customer.wishListRestaurants = doc['wishListRestaurants'];
                customer.location = doc['location'];
                // customer.appVersion = fieldCheck!.containsKey("appVersion") ? doc['appVersion'] : "";

                print(customer.docId);
                print("the version is ${customer.appVersion}");
                print("DATA INITIALIZED, THE DOC ID IS ${customer.docId}");
                if (customer.phoneNumber == "") {
                  print(
                      "${customer.phoneNumber} -/-/-/-//-/-/-/-/-/-//- This customer.phoneNumber must be empty");
                }
                if (customer.email == "") {
                  print(
                      "${customer.email} -/-/-/-//-/-/-/-/-/-//- This customer.email must be empty");
                }
              })
            });
  }

  //Customer exists check google
  Future<bool> customerExistsGoogle(String email) async {
    bool customerExists = false;
    await customerCollection
        .where(
          'email',
          isEqualTo: email,
        )
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.size > 0) {
        customerExists = true;
      } else {
        customerExists = false;
      }
    });
    return customerExists;
  }

  //Google sign in
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    googleSignInAccount =
        await googleSignIn.signIn(); // returns a Future<GoogleSignInAccount?>


    if (googleSignInAccount != null) {

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;



      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);


      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;
    }
  }

  Future<void> signOutFromGoogle() async {
    await googleSignIn.signOut();
    await auth.signOut();
  }

  //Update lastLogin
  Future<void> updateLastLogin(String docId) async {
    await customerCollection.doc(docId).update({'lastLogin': Timestamp.now()});
    print("Last Login has been updated in database");
  }

  Future<void> updatePhoneNumberinDB(String docId) async {
      await customerCollection.doc(docId).update({'phoneNumber': "customer.phoneNumber"});
    print("Phone NO. has been updated and added in database");

  }

  //Update userName
  Future<void> updateUserName(String docId) async {
    await customerCollection.doc(docId).update({'name': customer.name});
  }

//Update loginType
  Future<void> updateLoginType(String docId, String loginType) async {
    await customerCollection.doc(docId).update({'loginType': loginType});
    print("Login type has been updated in database");
  }

  Future<void> updateGmail(String docId, String gmailId) async {
    await customerCollection.doc(docId).update({'email': gmailId});
    print("Gmail ID has been updated in database");
  }
   Future<void> updateName(String docId, String name) async {
    await customerCollection.doc(docId).update({'name': name});
    print("Customer's Name has been updated in database");
  }
}
