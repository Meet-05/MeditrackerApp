import 'package:flutter/material.dart';
import 'package:app_frontend/contollers/symptoms/symptom_provider.dart';
import 'package:provider/provider.dart';
import 'package:app_frontend/constants.dart';

class CustomBottomRow extends StatelessWidget {
  const CustomBottomRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          border: Border.all(color: Colors.black)),
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
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  border: Border.all(color: Colors.black)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    symptom,
                    style: kStyle.copyWith(fontSize: 18.0),
                  ),
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
    );
  }
}
