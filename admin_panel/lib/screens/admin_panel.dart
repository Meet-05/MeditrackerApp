import 'package:flutter/material.dart';
import '../widgets/symptom_container.dart';
// import '../widgets/medicine_container.dart';
import 'package:admin_panel/constants.dart';

class AdminPanelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text('Top Symptoms', style: kstyle),
              SymptomContainer(
                collection: 'symptom',
              ),
              Text(
                'Top Medicines',
                style: kstyle,
              ),
              SymptomContainer(
                collection: 'medicine',
              )
            ]),
      )),
    );
  }
}
