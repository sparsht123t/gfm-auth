import 'package:flutter/material.dart';
import 'package:gfm_auth/models/retaurant.dart';

class FetchingCalls extends ChangeNotifier {
  bool firstRun = true;
  bool distanceChangeLoading = false;
  bool locationDenied = false;
  bool locationLoading = false;
  bool endOfTheList = false;
  bool loadingMoreNearbyRestaurants = false;

  List<Restaurant> restaurantList = [];
  List<String> nearbyRestaurantIds = [];
  List<num> nearbyRestaurantDistance = [];
  List<dynamic> decodedListOfLists = [];

  double userLat = 0;
  double userLong = 0;
  int geoHashIndex = 0;

  // LocationPermission? permission;

  checkLocationPermission() async {
    distanceChangeLoading = true;
    locationLoading = true;
    notifyListeners();
    //   permission = await Geolocator.checkPermission();

    //   if (permission == LocationPermission.whileInUse) {
    //     await Geolocator.getCurrentPosition(
    //             desiredAccuracy: LocationAccuracy.best)
    //         .then((value) async {
    //       userLat = value.latitude;
    //       userLong = value.longitude;
    //       await getGeoHashes(true, userLat, userLong);
    //     });

    //   } else {
    //     await Geolocator.requestPermission().then((value) async => {
    //           if (value == LocationPermission.denied ||
    //               value == LocationPermission.deniedForever)
    //             {
    //               locationDenied = true,

    //               notifyListeners(),

    //             }

    //           else
    //             {
    //               locationDenied = false,
    //               notifyListeners(),
    //               await Geolocator.getCurrentPosition(
    //                       desiredAccuracy: LocationAccuracy.best)
    //                   .then((value) async {
    //                 userLat = value.latitude;
    //                 userLong = value.longitude;
    //                 await getGeoHashes(true, userLat, userLong);

    //               }),
    //             }
    //         });
    //   }
    //   locationLoading = false;
    //   print("$userLong");
    //   print("$userLat");
    //   notifyListeners();
    // }

    getGeoHashes(bool firstRun, double lat, double long) async {
      loadingMoreNearbyRestaurants = true;
      bool tempBoolFlag = false;
      notifyListeners();

      //Check if first call, if first call, get first index
      //or else keep appending the list
      if (firstRun) {
        notifyListeners();
        tempBoolFlag = false;
        geoHashIndex = 0;
        nearbyRestaurantIds.clear();
        nearbyRestaurantDistance.clear();
        restaurantList.clear();
      } else {
        tempBoolFlag = true;
        if (geoHashIndex != decodedListOfLists.length - 1) {
          geoHashIndex += 1;
        } else {
          endOfTheList = true;
          print("END OF THE LIST");
        }
      }
    }
  }
}
