import 'package:flutter/material.dart';

class ShowDiseaseScreen extends StatelessWidget {
  String disease;
  ShowDiseaseScreen({this.disease});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(disease),
      ),
    );
  }
}
