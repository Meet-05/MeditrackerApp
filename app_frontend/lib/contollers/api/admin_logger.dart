import 'package:geocoder/geocoder.dart';
import '../services/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

User user = FirebaseAuth.instance.currentUser;
//gives user id,location
Future<String> getUserDetal() async {
  Location location = Location();
  await location.getLocation();
  var myAddress = await Geocoder.local.findAddressesFromCoordinates(
      Coordinates(location.latitude, location.longitude));
  var user_city = myAddress.first.locality;
  return user_city;
}

//logs the  userid,symptom selected and location of the user q
void logSymptom(List<String> symptoms) async {
  String city = await getUserDetal();
  symptoms.forEach((symptom) {
    FirebaseFirestore.instance.collection('symptom').add({
      'name': symptom,
      'timeStamp': Timestamp.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch)
          .toString(),
      'userId': user.uid,
      'city': city,
    });
  });
}

void medicineLogger(String medicine) async {
  String city = await getUserDetal();

  FirebaseFirestore.instance.collection('medicine').add({
    'name': medicine,
    'timeStamp': Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)
        .toString(),
    'userId': user.uid,
    'city': city,
  });
}
