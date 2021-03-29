import 'package:app_frontend/constants.dart' as constant;
import 'package:flutter/material.dart';
import 'package:app_frontend/contollers/authentication/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:app_frontend/contollers/symptoms/symptom_provider.dart';
import '../widgets/custom_bottom_sheet.dart';
import 'package:app_frontend/constants.dart';
import 'package:app_frontend/contollers/api/api.dart';
import './show_disease_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(children: [
            CustomSearchBar(),
            SymptomList(),
            CustomBottomRow(),
            NextButton()
          ])),
    ));
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
  }) : super(key: key);
  // void findIndex(List<String> selectedSymptoms) {
  //   List<int> symptomIndex =
  //       selectedSymptoms.map((e) => constant.symptoms.indexOf(e)).toList();
  //   for (int i in symptomIndex) {
  //     print(i);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
          child: Card(
            elevation: 20.0,
            shape: StadiumBorder(),
            child: Padding(
                padding: const EdgeInsets.all(10.0), child: Text('Next')),
          ),
          onPressed: () async {
            List<String> selectedSymptoms =
                Provider.of<SymptomProvider>(context, listen: false)
                    .selectedSymptoms;
            var result = await getPrediction(selectedSymptoms);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowDiseaseScreen(disease: result)));
          }),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
      child: TextField(
        style: TextStyle(
          fontSize: 30.0,
        ),
        decoration: InputDecoration(border: OutlineInputBorder()),
        onChanged: (value) {
          Provider.of<SymptomProvider>(context, listen: false)
              .searchResult(value);
          // _provider.searchResult(value);
        },
      ),
    );
  }
}

class SymptomList extends StatelessWidget {
  const SymptomList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: ListView.builder(
          itemCount:
              Provider.of<SymptomProvider>(context).symptomsToShow.length,
          // _provider.symptomsToShow.length,
          itemBuilder: (context, index) {
            String symptom =
                Provider.of<SymptomProvider>(context).symptomsToShow[index];
            return ListTile(
                onTap: () {
                  Provider.of<SymptomProvider>(context, listen: false)
                      .onTap(symptom);
                  // _provider.onTap(_provider.symptomsToShow[index]);
                },
                title: Text(symptom),
                trailing: Provider.of<SymptomProvider>(context)
                        .selectedSymptoms
                        .contains(symptom)
                    ? Icon(Icons.check_box)
                    : Text(''));
          }),
    );
  }
}

class CustomBottomRow extends StatelessWidget {
  const CustomBottomRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                Provider.of<SymptomProvider>(context).selectedSymptoms.length,
            // _provider.selectedSymptoms.length,
            itemBuilder: (context, index) {
              String symptom =
                  Provider.of<SymptomProvider>(context).selectedSymptoms[index];
              return Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    border: Border.all(color: Colors.black)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(symptom),
                    IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          Provider.of<SymptomProvider>(context, listen: false)
                              .onTap(symptom);
                        })
                  ],
                ),
              );
            }),
      ),
    );
  }
}
