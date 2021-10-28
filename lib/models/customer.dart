import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
    String authId = "";
  String docId = "";
  String name = "";
  String email = "";
  String photoUrl = "";
  String loginType = "";
  String phoneNumber = "";
  String cartRestaurantId = "";
  String appVersion = "";
  late Timestamp lastLogin;
  GeoPoint location = new GeoPoint(0, 0);

  List<dynamic> cart = [];
  List<dynamic> cartQuantity = [];
  List<dynamic> wishListFood = [];
  List<dynamic> wishListRestaurants = [];
  List<dynamic> orders = [];
}
