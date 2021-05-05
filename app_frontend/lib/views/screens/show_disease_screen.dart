import 'package:flutter/material.dart';
import 'package:app_frontend/constants.dart';

class ShowDiseaseScreen extends StatelessWidget {
  final String disease;
  final List<dynamic> doctors;
  ShowDiseaseScreen({this.disease, this.doctors});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF4F5F9),
        body: SafeArea(
          child: Column(
            children: [
              if (disease != '')
                Center(
                  child: DiseaseContainer(disease: disease),
                ),
              DoctorContainer(disease: disease, doctors: doctors)
            ],
          ),
        ));
  }
}

class DiseaseContainer extends StatelessWidget {
  const DiseaseContainer({
    Key key,
    @required this.disease,
  }) : super(key: key);

  final String disease;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Text(
        disease,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
      ),
    );
  }
}

class DoctorContainer extends StatelessWidget {
  const DoctorContainer({
    Key key,
    @required this.disease,
    @required this.doctors,
  }) : super(key: key);

  final String disease;
  final List doctors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.blue[100],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Doctors Treating $disease nearby',
                style: kStyle,
              ),
            ),
            SizedBox(height: 20.0),
            DoctorList(doctors: doctors),
          ],
        ),
      ),
    );
  }
}

class DoctorList extends StatelessWidget {
  const DoctorList({
    Key key,
    @required this.doctors,
  }) : super(key: key);

  final List doctors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: ListTile(
                title: Text(
                  doctors[index]['name'],
                  style: kStyle,
                ),
                subtitle: Text(
                  '${doctors[index]['phone']}',
                  style: kStyle.copyWith(fontSize: 16.0),
                ),
                trailing: Text(
                  '${doctors[index]['distance'].toStringAsFixed(1)} kms ',
                  style: kStyle,
                ),
              ),
            );
          }),
    );
  }
}
