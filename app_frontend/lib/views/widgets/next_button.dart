import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:app_frontend/contollers/api/api.dart';
import 'package:provider/provider.dart';
import 'package:app_frontend/contollers/symptoms/symptom_provider.dart';
import '../screens/show_disease_screen.dart';
import 'package:provider/provider.dart';
import 'package:app_frontend/contollers/symptoms/symptom_provider.dart';
import 'package:app_frontend/contollers/api/admin_logger.dart';

class NextButton extends StatefulWidget {
  const NextButton({
    Key key,
  }) : super(key: key);

  @override
  _NextButtonState createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  bool isProcessing = false;
  var doctors;
  var result;
  @override
  Widget build(BuildContext context) {
    String data = Provider.of<SymptomProvider>(context).global_query;
    int search_result =
        Provider.of<SymptomProvider>(context).symptomsToShow.length;

    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      height: 50.0,
      width: double.infinity,
      child: isProcessing
          ? Center(
              child:
                  JumpingDotsProgressIndicator(numberOfDots: 3, fontSize: 30.0))
          : MaterialButton(
              child: Text(
                'Next',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                List<String> selectedSymptoms =
                    Provider.of<SymptomProvider>(context, listen: false)
                        .selectedSymptoms;

                if (selectedSymptoms.length > 0 || search_result == 0) {
                  setState(() {
                    isProcessing = true;
                  });
                  if (search_result == 0) {
                    addSymptom(data);
                    result = '';
                  } else {
                    result = await getPrediction(selectedSymptoms);
                  }

                  var doctors = await findLocalDoctors(result);
                  setState(() {
                    isProcessing = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowDiseaseScreen(
                                disease: result,
                                doctors: doctors,
                              )));
                } else {
                  print('not selected');
                }
                logSymptom(selectedSymptoms);
              }),
    );
  }
}
