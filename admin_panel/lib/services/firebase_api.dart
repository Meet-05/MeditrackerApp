import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseApi {
  static Stream readSymptoms() =>
      FirebaseFirestore.instance.collection('admin').snapshots();
}
