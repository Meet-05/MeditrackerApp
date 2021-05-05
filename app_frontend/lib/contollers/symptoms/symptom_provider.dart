import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:app_frontend/constants.dart' as constant;

class SymptomProvider extends ChangeNotifier {
  List<String> symptoms = constant.symptoms;

  List<String> get getSymptoms => [...symptoms];

  List<String> selectedSymptoms = [];

  List<String> symptomsToShow = [...constant.symptoms];
  String global_query;
  void searchResult(String query) {
    print(query);
    global_query = query;
    List<String> results = [];
    for (String symptom in symptoms) {
      if (symptom.contains(query)) {
        results.add(symptom);
      }
    }
    symptomsToShow = results;
    notifyListeners();
  }

  void onTap(String symptom) {
    if (selectedSymptoms.contains(symptom)) {
      selectedSymptoms.remove(symptom);
    } else {
      selectedSymptoms.add(symptom);
    }
    notifyListeners();
  }
}
