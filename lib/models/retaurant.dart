import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {

  String restaurantName = "";
  String address = "";
  String restaurantImageURL = "";
  String restaurantID = "";
  String geohash = "";
  String locationUrl = "";
  String phoneNumber = "";
  String open_time = "";
  String close_time = "";
  num totalDishesAvailable = 0;
  Map timing = Map<String,String>();
  GeoPoint coordinates = GeoPoint(0,0);
  bool restaurantStatus = false;
}