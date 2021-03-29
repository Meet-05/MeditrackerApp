import 'package:flutter/material.dart';
import 'package:app_frontend/contollers/symptoms/symptom_provider.dart';
import 'package:provider/provider.dart';

class CustomBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<SymptomProvider>(context).selectedSymptoms;
    return Scaffold(
      body: Container(
        child: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: _provider.length,
                itemBuilder: (context, index) {
                  print('hy');
                  return ListTile(
                    title: Text(_provider[index]),
                    trailing: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          Provider.of<SymptomProvider>(context)
                              .onTap(_provider[index]);
                        }),
                  );
                }),
          ),
          MaterialButton(
              child: Card(
                elevation: 20.0,
                shape: StadiumBorder(),
                child: Padding(
                    padding: const EdgeInsets.all(10.0), child: Text('Next')),
              ),
              onPressed: () {})
        ]),
      ),
    );
  }
}
