import 'package:flutter/material.dart';

class ShowDiseaseScreen extends StatelessWidget {
  final String disease;
  final List<dynamic> doctors;
  ShowDiseaseScreen({this.disease, this.doctors});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(20.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Text(
                disease,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0))),
              child: ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: ListTile(
                        title: Text(doctors[index]['name']),
                        subtitle: Text('${doctors[index]['phone']}'),
                        trailing: Text(
                            '${doctors[index]['distance'].toStringAsFixed(1)} kms away'),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    ));
  }
}
