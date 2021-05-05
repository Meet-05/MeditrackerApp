import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_frontend/constants.dart' as constant;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_frontend/contollers/services/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future getPrediction(List<String> selectedSymptoms) async {
  List<int> symptomIndex =
      selectedSymptoms.map((e) => constant.symptoms.indexOf(e)).toList();
  print(symptomIndex[0]);
  Map<String, List<int>> data = {'symptoms': symptomIndex};
  var body = json.encode(data);
  // http://10.0.2.2:8000/v1/predict
  var url = Uri.parse('https://meditracker-apiv1.herokuapp.com/v1/predict');
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: body);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  var result = jsonDecode(response.body);
  print(result['result']);
  return result['result'];
}

final firestoreInstance = FirebaseFirestore.instance;
User user = FirebaseAuth.instance.currentUser;

void addSymptom(String symptom) {
  firestoreInstance
      .collection('symptomsAdded')
      .add({'userId': user.uid, 'symptomAdded': symptom});
}

Future<dynamic> findLocalDoctors(String disease) async {
  //find current exact location of user
  Location location = Location();
  await location.getLocation();
  print(location.latitude);
  print(location.longitude);

//find the current city of user
  var myAddress = await Geocoder.local.findAddressesFromCoordinates(
      Coordinates(location.latitude, location.longitude));
  var myCity = myAddress.first.locality;
  print(myCity);

  //fetch all the doctors treating the disease predicted in the user's city
  var result = await firestoreInstance
      .collection("doctors")
      .where("city", isEqualTo: myCity)
      .where("diseases", arrayContains: disease)
      .get();

  List<dynamic> tempList = [];

  //calculate the distance from the users location to the doctors found
  for (int i = 0; i < result.docs.length; i++) {
    var dist = Geolocator.distanceBetween(location.latitude, location.longitude,
        result.docs[i].data()['lat'], result.docs[i].data()['long']);
    dist = dist / 1000;
    tempList.add({
      'name': result.docs[i].data()['name'],
      'phone': result.docs[i].data()['phone'],
      'city': result.docs[i].data()['city'],
      'distance': dist
    });
  }

//sorting the doctors list based on the current location of the user
  tempList.sort((a, b) => a['distance'].compareTo(b['distance']));
  tempList.forEach((element) {
    print(" ${element['name']} is ${element['distance']} away");
  });
  return tempList;
}
// --used to store doctor data in cloudifirestore
// for (var doctor in constant.doctors) {
//   var coordinates = new Coordinates(doctor['lat'], doctor['long']);
//   var address =
//       await Geocoder.local.findAddressesFromCoordinates(coordinates);
//   var first = address.first;
//   doctor["city"] = first.locality;
//   print(first.locality);
//   firestoreInstance.collection("doctors").add({
//     "name": doctor["name"],
//     "phone": doctor["phone"],
//     "lat": doctor["lat"],
//     "long": doctor["long"],
//     "city": doctor["city"],
//     "opening": doctor["opening"],
//     "closing": doctor["closing"],
//     "diseases": doctor["diseases"]
//   }).then((_) {
//     print("success!");
//   });
// }
