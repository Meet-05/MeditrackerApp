import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pie_chart/pie_chart.dart';

class SymptomContainer extends StatefulWidget {
  String collection;
  SymptomContainer({this.collection});

  @override
  _SymptomContainerState createState() => _SymptomContainerState();
}

class _SymptomContainerState extends State<SymptomContainer> {
  Map<String, double> pieChart = {};
  var lists;
  String _chosenValue = 'All';

  void locationFilter(dynamic documents) {
    pieChart = {};

    documents.forEach((doc) {
      if (doc['city'] == _chosenValue) {
        if (pieChart.containsKey(doc['name'])) {
          pieChart[doc['name']] += 1;
        } else {
          pieChart[doc['name']] = 1;
        }
      }
    });
    setState(() {});
  }

  void createPiechart(dynamic documents, String _chosenValue) {
    documents.forEach((doc) {
      if (doc['city'] == _chosenValue || _chosenValue == 'All') {
        if (pieChart.containsKey(doc['name'])) {
          pieChart[doc['name']] += 1;
        } else {
          pieChart[doc['name']] = 1;
        }
        // print(doc['name']);
      }
    });

    print(pieChart);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(40.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      height: 500,
      width: 800,
      child: Column(
        children: <Widget>[
          Align(alignment: Alignment.centerRight, child: buildDropdownButton()),
          SizedBox(height: 20.0),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(widget.collection)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final documents = snapshot.data.docs;
                lists = documents;
                createPiechart(documents, _chosenValue);
                return PieChart(
                  dataMap: pieChart,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width / 3.2,
                  chartType: ChartType.disc,
                  showChartValuesInPercentage: true,
                );
              }),
        ],
      ),
    );
  }

  DropdownButton<String> buildDropdownButton() {
    return DropdownButton<String>(
      focusColor: Colors.white,
      value: _chosenValue,
      //elevation: 5,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      items: <String>[
        'All',
        'Mountain View',
        'Mumbai',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      hint: Text(
        "Please choose a langauage",
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: (String value) {
        print('value chose is $value');
        setState(() {
          _chosenValue = value;
        });
        locationFilter(lists);
      },
    );
  }
}
