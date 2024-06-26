import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart'as http;

class GoogleProvider extends ChangeNotifier {

  bool suggestions = false;

  var searchController = TextEditingController();

  List<dynamic> placesList = [];

  var uuid = Uuid();
  String? sessionToken;

  Completer<GoogleMapController> gController = Completer();

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(31.418715, 73.079109),
    zoom: 14,
  );

  // List<Marker> marker = <Marker>[
  // ];

  Future<Position> getUserCurrentLocation()async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace) {
      debugPrint("$error");
    });
    return await Geolocator.getCurrentPosition();
  }

  saveLocation(context){
    Navigator.pop(context);
    // marker.clear();
    notifyListeners();
  }

  location(){
    getUserCurrentLocation().then((value) async {
      kGooglePlex = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );
      notifyListeners();
      GoogleMapController controller = await gController.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(
          kGooglePlex = CameraPosition(
              target: LatLng(value.latitude,value.longitude),
              zoom: 14
          )
      ));
      garageLatitude = value.latitude.toString();
      garageLongitude = value.longitude.toString();
      List<Placemark> place = await placemarkFromCoordinates(value.latitude, value.longitude);
      searchController.text = "${place.reversed.last.street}, ${place.reversed.last.subLocality},"
          " ${place.reversed.last.locality}, ${place.reversed.last.postalCode} ${place.reversed.last.country}";
      notifyListeners();
    });
  }

  moveLocation(latitude,longitude,index) async {

     garageLatitude = latitude.toString();
     garageLongitude = longitude.toString();
     notifyListeners();
    // debugPrint("=============${marker.length}=============");

    searchController.text = placesList[index]["description"];
    notifyListeners();

    kGooglePlex = CameraPosition(
        target: LatLng(latitude,longitude),
        zoom: 14
    );
    GoogleMapController controller = await gController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(latitude,longitude),
            zoom: 14
        )
    ));
    notifyListeners();
  }


  onChanged(searchResult){
    if(sessionToken == null){
      sessionToken == uuid.v4();
      notifyListeners();
    }
    getSuggestion(searchResult);
  }

  void getSuggestion(String input)async{
    String kPLACES_API_KEY = "AIzaSyCog7RsE7QqPGoGhJePgBaaXqNbuO8fDAE";
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    print("data");
    print(data);
    if(response.statusCode == 200){
      placesList = jsonDecode(response.body.toString())["predictions"];
      notifyListeners();
    }else{
      throw Exception("Failed to Load ");
    }

  }

}


//     .add(Marker(
// markerId: MarkerId("1"),
// position: LatLng(latitude,longitude),
// infoWindow: InfoWindow(
// title: "Your Location",
// ),
// )
// )



// @override
// void initState() {
//   // TODO: implement initState
//   super.initState();
//   searchController.addListener(() {
//     onChanged();
//   });
//   loadLocation();
// }

String garageLatitude = "";
String garageLongitude = "";