import 'package:flutter/material.dart';
import 'package:app_frontend/contollers/symptoms/symptom_provider.dart';
import 'package:provider/provider.dart';
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
          fontSize: 25.0,
        ),
        decoration: InputDecoration(
            suffix: Icon(
              Icons.search,
              size: 30.0,
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search for Symptom',
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.white),
              borderRadius: new BorderRadius.circular(25.7),
            )),
        onChanged: (value) {
          Provider.of<SymptomProvider>(context, listen: false)
              .searchResult(value);
          // _provider.searchResult(value);
        },
      ),
    );
  }
}