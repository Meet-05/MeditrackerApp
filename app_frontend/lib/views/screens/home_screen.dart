import 'package:flutter/material.dart';
import 'package:app_frontend/contollers/authentication/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
        ),
        body: TextButton(
            child: Text('logout'),
            onPressed: () {
              Provider.of<GoogleSignInProvider>(context, listen: false)
                  .logout();
            }));
  }
}
