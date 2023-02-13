// import 'dart:convert';
import 'package:bizhub_new/repo/places_repo.dart';
// import 'package:bizhub_new/utils/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../model/place_detail_model.dart';
import '../model/auto_complete_prediction.dart';
import '../model/place_auto_complete.dart';
import '../model/place_detail_model.dart';
import '../utils/routes/routes_name.dart';
import '../utils/shared_prefrences.dart';
// import '../model/place_model.dart';

// class LocationViewModel with ChangeNotifier {
//   PlaceDetailModel myCurrentLocation = PlaceDetailModel.fromEmptyJson();
//   LatLng latLng = const LatLng(0.0, 0.0);
//   String address = '';

//   //   LatLng latLng = const LatLng(0.0, 0.0);
// //   String address = '';
// //   String postalCode = '';

//   // GetLocationViewModel(): longitude=0,latitude=0,address='';

//   set setAddress(
//     String address,
//   ) {
//     this.address = address;
//     notifyListeners();
//   }

//   String get getAddress => address;

//   final GeolocatorPlatform _geoLocatorPlatform = GeolocatorPlatform.instance;

//   updateMyLocation() {
//     // if (placeDetailModel.placeAddress.isNotEmpty) {
//     //   myCurrentLocation = placeDetailModel;
//     //   if (setValue) {
//     //     setLocalCoordinates(placeDetailModel);
//     //   }
//     //   notifyListeners();
//     //   // Navigator.of(context).pop();
//     // } else {
//     //   // Fluttertoast.showToast(msg: "Please select a location");
//     // }
//     if (placeDetailModel.placeAddress.isNotEmpty) {
//       myCurrentLocation = placeDetailModel;
//       notifyListeners();
//     }
//   }

//   // updatDestinationLoaction(context) {
//   //   if (placeDetailModel.placeAddress.isNotEmpty) {
//   //     myDestinationLocation = placeDetailModel;
//   //     notifyListeners();
//   //     // Navigator.of(context).pop();
//   //   } else {
//   //     // Fluttertoast.showToast(msg: 'Please select a destination');
//   //   }
//   // }

//   String get getMyAddress => myCurrentLocation.placeAddress;
//   // String get getDestinationAddress => myDestinationLocation.placeAddress;

//   Future<bool> _handlePermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission != LocationPermission.always) {
//       permission = await _geoLocatorPlatform.requestPermission();
//       if (permission == LocationPermission.always ||
//           permission == LocationPermission.whileInUse) {
//         return true;
//       } else {
//         return false;
//       }
//     } else {
//       return true;
//     }
//   }

//   // Future<void> getLocationFromCoordinates(LatLng coordinate) async {
//   //   List<Placemark> placeMarks = await placemarkFromCoordinates(
//   //     coordinate.latitude,
//   //     coordinate.longitude,
//   //   );
//   //   final address = placeMarks.first;
//   //   setAddress =
//   //       '${address.street}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}';
//   //   setAddress = this.address.replaceAll(', ,', ',');

//   //   setLocalCoordinates(
//   //     PlaceDetailModel(placeAddress: getAddress, placeLocation: coordinate),
//   //   );
//   // }

//   Future<void> getLocationFromCoordinates(LatLng coordinate) async {
//     // bool permission = await _handlePermission();
//     // if (permission) {
//     // final geoPosition = await Geolocator.getCurrentPosition(
//     //   desiredAccuracy: LocationAccuracy.high,
//     // );
//     // latLng = LatLng(geoPosition.latitude, geoPosition.longitude);
//     // // final registrationCompanyProvider =
//     // //     Provider.of<RegisterCompanyViewModel>(context, listen: false);

//     // await getLocationFromCoordinates(latLng);
//     // return latLng;
//     List<Placemark> placeMarks = await placemarkFromCoordinates(
//       coordinate.latitude,
//       coordinate.longitude,
//     );
//     final address = placeMarks.first;
//     setAddress =
//         '${address.street}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}';
//     setAddress = this.address.replaceAll(', ,', ',');
//     // }
//     // setLocalCoordinates(
//     //     PlaceDetailModel(placeAddress: getAddress, placeLocation: coordinate));
//   }

//   setLocalCoordinates(PlaceDetailModel placeModel) async {
//     // placeDetailModel = PlaceDetailModel(
//     //   placeAddress: getAddress,
//     //   placeLocation: coordinate,
//     // );
//     await prefrences.setSharedPreferenceValue(
//       'longitude',
//       placeModel.placeLocation.longitude.toString(),
//     );
//     await prefrences.setSharedPreferenceValue(
//       'latitude',
//       placeModel.placeLocation.latitude.toString(),
//     );
//     await prefrences.setSharedPreferenceValue(
//       'address',
//       placeModel.placeAddress,
//     );
//     notifyListeners();
//     getLocalCoordinates();
//   }

//   Future<void> getLocalCoordinates() async {
//     final longitude = await prefrences.getSharedPreferenceValue('longitude');
//     final latitude = await prefrences.getSharedPreferenceValue('latitude');
//     final address = await prefrences.getSharedPreferenceValue('address');

//     myCurrentLocation = PlaceDetailModel(
//       placeAddress: address.toString(),
//       placeLocation: LatLng(
//         double.parse(latitude.toString()),
//         double.parse(longitude.toString()),
//       ),
//     );
//     notifyListeners();
//   }

//   final prefrences = Prefrences();

//   Future<LatLng?> getCurrentLocation({required BuildContext context}) async {
//     bool permission = await _handlePermission();
//     if (permission) {
//       final geoPosition = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       latLng = LatLng(geoPosition.latitude, geoPosition.longitude);
//       // final registrationCompanyProvider =
//       //     Provider.of<RegisterCompanyViewModel>(context, listen: false);

//       await getLocationFromCoordinates(latLng);
//       return latLng;
//     }
//     return null;
//   }

//   Future<void> getStoreLocationIfExist(BuildContext context) async {
//     final longitude = await prefrences.getSharedPreferenceValue('longitude');
//     // final latitude = await utilities.getSharedPreferenceValue('latitude');
//     // final address = await utilities.getSharedPreferenceValue('address');
//     // print('$longitude long');
//     // print('$latitude lat');
//     // print('$address address');
//     if (longitude == null) {
//       LatLng currentCordinates =
//           await getCurrentLocation(context: context) ?? const LatLng(0.0, 0.0);
//       myCurrentLocation = PlaceDetailModel(
//         placeAddress: getAddress,
//         placeLocation: currentCordinates,
//       );
//     }
//     if (longitude != null) {
//       await getLocalCoordinates();
//     }
//     notifyListeners();
//   }

//   setLatLng(LatLng latitudeAndLogitude) async {
//     latLng = latitudeAndLogitude;
//     await getLocationFromCoordinates(latitudeAndLogitude);
//     notifyListeners();
//   }

//   List<PlacesModel> placesList = [];
//   PlaceDetailModel placeDetailModel = PlaceDetailModel.fromEmptyJson();
//   // PlaceWebService placeWebService = PlaceWebService();
//   PlacesRepo placeWebService = PlacesRepo();

//   Future<void> getPlaces(String query) async {
//     // if (!(await Utilities().isInternetAvailable())) {
//     //   return;
//     // }
//     placesList = await placeWebService.getPlaces(query);
//     notifyListeners();
//   }

// //cleared function
//   Future<void> getPlaceDetail(String placeId) async {
//     placeDetailModel = await placeWebService.getPlaceDetail(placeId);
//     // print(placeDetailModel.placeAddress);
//     notifyListeners();
//   }
// }

class LocationViewModel with ChangeNotifier {
  // double? latitude;
  // double? longitude;
  PlaceDetailModel mySearchLocation = PlaceDetailModel.fromEmptyJson();
  // PlaceDetailModel placeDetailModel = PlaceDetailModel.fromEmptyJson();
  PlacesRepo placeWebService = PlacesRepo();
  final prefrences = Prefrences();
  LatLng latLng = const LatLng(0.0, 0.0);
  String locationAddress = "";

  LatLng? mylatLng;
  String? mylocationAddress;
  bool checkGetMyLocation = false;

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoad(bool status) {
    _loading = status;
    notifyListeners();
  }

  getLatLong(BuildContext context) {
    Future<Position> data = _determinePosition(context);
    data.then((value) {
      // print("value $value");
      // setState(() {
      //   lat = value.latitude;
      //   long = value.longitude;
      // });
      latLng = LatLng(value.latitude, value.longitude);
      // latitude = value.latitude;
      // longitude = value.longitude;

      getAddress(value.latitude, value.longitude);
      notifyListeners();
    }).catchError((error) {
      // print("Error $error");
    });
  }

  getMyLatLong(BuildContext context) async {
    setLoad(true);
    Future<Position> data = _determinePosition(context);
    await data.then((value) async {
      // print("value $value");
      // setState(() {
      //   lat = value.latitude;
      //   long = value.longitude;
      // });
      mylatLng = LatLng(value.latitude, value.longitude);
      // latitude = value.latitude;
      // longitude = value.longitude;

      getMyAddress(value.latitude, value.longitude);
      await prefrences.setSharedPreferenceBoolValue('myloc', true);

      // notifyListeners();
      // if (mylocationAddress.isNotEmpty) {
      setLoad(false);
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.of(context).pushReplacementNamed(RouteName.home);
      });
      // }
    }).catchError((error) {
      // print("Error $error");
    });
  }

  //For convert lat long to address
  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    // '${address.street}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}'
    // setState(() {
    locationAddress =
        "${placemarks[0].street!}, ${placemarks[0].locality!}, ${placemarks[0].administrativeArea!}, ${placemarks[0].postalCode!}, ${placemarks[0].country!}";
    // });

    for (int i = 0; i < placemarks.length; i++) {
      // print("INDEX $i ${placemarks[i]}");
    }
    print(locationAddress);
    // notifyListeners();
  }

  getMyAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    // '${address.street}, ${address.subLocality}, ${address.locality}, ${address.administrativeArea}, ${address.postalCode}, ${address.country}'
    // setState(() {

    // final address = placemarks;

    // mylocationAddress =
    //     "${placemarks[0].street!}, ${placemarks[0].locality!}, ${placemarks[0].administrativeArea!}, ${placemarks[0].postalCode!}, ${placemarks[0].country!}";

    mylocationAddress =
        "${placemarks[0].administrativeArea!}, ${placemarks[0].country!}";
    // });

    // mylocationAddress.replaceAll(', ,', ',');

    // mylocationAddress = address

    for (int i = 0; i < placemarks.length; i++) {
      // print("INDEX $i ${placemarks[i]}");
    }
    print(mylocationAddress);
    // notifyListeners();
  }

  String mapAPIKEY = 'AIzaSyCSD5azLj8EdgAmcNdIFAq08bhij-4O7RU';

  List<AutoCompletePrediction> placePrediction = [];
  PlaceDetail? placesDetail;

  void placeAutoComplete(String query) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/autocomplete/json",
      {
        "input": query,
        "key": mapAPIKEY,
      },
    );

    String? response = await PlacesRepo.fetchUrl(uri);

    if (response != null) {
      // print(response);
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutoCompleteResult(response);
      if (result.prediction != null) {
        placePrediction = result.prediction!;
      }
      notifyListeners();
    }
  }

  void getNewPlaceDetail(String placeId) async {
    mySearchLocation = await placeWebService.fetchPlacesDetail(placeId);
    // print(mySearchLocation.placeAddress);
    if (mySearchLocation.placeAddress.isNotEmpty) {
      locationAddress = mySearchLocation.placeAddress;
      latLng = mySearchLocation.placeLocation;
    }
    notifyListeners();
  }

  void getMyPlaceDetail(String placeId) async {
    mySearchLocation = await placeWebService.fetchPlacesDetail(placeId);
    // print(mySearchLocation.placeAddress);
    if (mySearchLocation.placeAddress.isNotEmpty) {
      mylocationAddress = mySearchLocation.placeAddress;
      mylatLng = mySearchLocation.placeLocation;
    }
    notifyListeners();
  }

  // LatLng? _center;
  // Position? currentLocation;

  // Future<Position> locateUser() async {
  //   return Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  // }

  // getUserLocation() async {
  //   Future<Position> data = _determinePosition();
  //   // currentLocation = await locateUser();

  //   data.then((value) {
  //     _center = LatLng(currentLocation!.latitude, currentLocation!.longitude);
  //     notifyListeners();
  //   });
  //   print('center $_center');
  // }
}
