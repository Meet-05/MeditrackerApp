import 'package:flutter/material.dart';
// import 'package:moor_flutter/moor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:app_frontend/contollers/symptoms/symptom_provider.dart';
import 'package:app_frontend/constants.dart';

class SymptomList extends StatelessWidget {
  const SymptomList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<SymptomProvider>(context).symptomsToShow;

    if (data.length > 0) {
      return Expanded(flex: 7, child: SearchResult());
    } else {
      return Expanded(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '🤔 ',
                style: TextStyle(fontSize: 50.0),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Symptom not recognized.\nClick on the next button to add this symptom and see nearby doctors ",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ));
    }
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Provider.of<SymptomProvider>(context).symptomsToShow.length,
        itemBuilder: (context, index) {
          String symptom =
              Provider.of<SymptomProvider>(context).symptomsToShow[index];

          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            margin: EdgeInsets.symmetric(vertical: 7.0),
            color: Provider.of<SymptomProvider>(context)
                    .selectedSymptoms
                    .contains(symptom)
                ? Colors.blue[100]
                : Colors.white,
            elevation: 3.0,
            child: ListTile(
                onTap: () {
                  Provider.of<SymptomProvider>(context, listen: false)
                      .onTap(symptom);
                  // _provider.onTap(_provider.symptomsToShow[index]);
                },
                title: Text(
                  symptom,
                  style: kStyle,
                ),
                trailing: Provider.of<SymptomProvider>(context)
                        .selectedSymptoms
                        .contains(symptom)
                    ? Icon(
                        Icons.check_box,
                        color: Colors.white,
                      )
                    : Text('')),
          );
        });
  }
}
