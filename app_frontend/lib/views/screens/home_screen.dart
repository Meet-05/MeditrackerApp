import 'package:flutter/material.dart';
import '../widgets/next_button.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_bottom_row.dart';
import 'package:app_frontend/contollers/symptoms/symptom_provider.dart';
import 'package:app_frontend/contollers/authentication/auth_provider.dart';
// import 'package:app_frontend/contollers/api/api.dart';
// import './show_disease_screen.dart';
import '../widgets/symptom_list.dart';
import '../widgets/custom_searchbar.dart';
import 'package:app_frontend/views/screens/medication_reminder_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            icon: Icon(
              Icons.medical_services,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyMedicineRemainder()));
            },
          ),
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Provider.of<GoogleSignInProvider>(context, listen: false)
                    .logout();
              })
        ]),
        backgroundColor: Color(0xFFF4F5F9),
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Column(children: [
                CustomSearchBar(),
                SymptomList(),
                CustomBottomRow(),
                NextButton()
              ])),
        ));
  }
}

// class CustomSearchBar extends StatelessWidget {
//   const CustomSearchBar({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
//       child: TextField(
//         style: TextStyle(
//           fontSize: 25.0,
//         ),
//         decoration: InputDecoration(
//             suffix: Icon(
//               Icons.search,
//               size: 30.0,
//             ),
//             filled: true,
//             fillColor: Colors.white,
//             hintText: 'Search for Symptom',
//             border: OutlineInputBorder(),
//             focusedBorder: OutlineInputBorder(
//               borderSide: new BorderSide(color: Colors.white),
//               borderRadius: new BorderRadius.circular(25.7),
//             )),
//         onChanged: (value) {
//           Provider.of<SymptomProvider>(context, listen: false)
//               .searchResult(value);
//           // _provider.searchResult(value);
//         },
//       ),
//     );
//   }
// }

// class SymptomList extends StatelessWidget {
//   const SymptomList({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 7,
//       child: ListView.builder(
//           itemCount:
//               Provider.of<SymptomProvider>(context).symptomsToShow.length,
//           itemBuilder: (context, index) {
//             String symptom =
//                 Provider.of<SymptomProvider>(context).symptomsToShow[index];
//             return Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(12.0))),
//               margin: EdgeInsets.symmetric(vertical: 7.0),
//               color: Provider.of<SymptomProvider>(context)
//                       .selectedSymptoms
//                       .contains(symptom)
//                   ? Colors.blue[100]
//                   : Colors.white,
//               elevation: 3.0,
//               child: ListTile(
//                   onTap: () {
//                     Provider.of<SymptomProvider>(context, listen: false)
//                         .onTap(symptom);
//                     // _provider.onTap(_provider.symptomsToShow[index]);
//                   },
//                   title: Text(symptom),
//                   trailing: Provider.of<SymptomProvider>(context)
//                           .selectedSymptoms
//                           .contains(symptom)
//                       ? Icon(
//                           Icons.check_box,
//                           color: Colors.white,
//                         )
//                       : Text('')),
//             );
//           }),
//     );
//   }
// }

// class CustomBottomRow extends StatelessWidget {
//   const CustomBottomRow({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 60.0,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(20.0)),
//           color: Colors.white,
//           border: Border.all(color: Colors.black)),
//       padding: EdgeInsets.symmetric(horizontal: 2.0),
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount:
//               Provider.of<SymptomProvider>(context).selectedSymptoms.length,
//           // _provider.selectedSymptoms.length,
//           itemBuilder: (context, index) {
//             String symptom =
//                 Provider.of<SymptomProvider>(context).selectedSymptoms[index];
//             return Container(
//               padding: EdgeInsets.symmetric(horizontal: 4.0),
//               margin: EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                   color: Colors.blue[100],
//                   borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                   border: Border.all(color: Colors.black)),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(symptom),
//                   IconButton(
//                       icon: Icon(Icons.cancel),
//                       onPressed: () {
//                         Provider.of<SymptomProvider>(context, listen: false)
//                             .onTap(symptom);
//                       })
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }
