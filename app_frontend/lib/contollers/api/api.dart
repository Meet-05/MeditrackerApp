import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_frontend/constants.dart' as constant;

Future getPrediction(List<String> selectedSymptoms) async {
  List<int> symptomIndex =
      selectedSymptoms.map((e) => constant.symptoms.indexOf(e)).toList();
  print(symptomIndex[0]);
  Map<String, List<int>> data = {'symptoms': symptomIndex};
  var body = json.encode(data);
  var url = Uri.parse('http://10.0.2.2:8000/v1/predict');
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: body);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  var result = jsonDecode(response.body);
  print(result['result']);
  return result['result'];
}
