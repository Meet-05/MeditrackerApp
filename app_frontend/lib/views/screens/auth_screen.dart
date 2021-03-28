import 'package:flutter/material.dart';
import '../widgets/signup_button.dart';
import 'package:provider/provider.dart';
import 'package:app_frontend/contollers/authentication/auth_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/logo.png',
          ),
          SizedBox(
            height: 40.0,
          ),
          SignupButton(
            iconToShow: FaIcon(
              FontAwesomeIcons.facebook,
              color: Colors.blue,
            ),
            text: 'Sign in with Facebook',
            onTap: () {
              Provider.of<GoogleSignInProvider>(context, listen: false).login();
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          BuildDivider(),
          SizedBox(
            height: 20.0,
          ),
          SignupButton(
            iconToShow: FaIcon(
              FontAwesomeIcons.google,
              color: Colors.red,
            ),
            text: 'Sign in with Google',
            onTap: () {
              Provider.of<GoogleSignInProvider>(context, listen: false).login();
            },
          ),
        ],
      ),
    );
  }
}

class BuildDivider extends StatelessWidget {
  const BuildDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
      child: Row(
        children: [
          Expanded(
              child: Divider(
            color: Colors.black,
          )),
          Text('  OR  '),
          Expanded(
              child: Divider(
            color: Colors.black,
          )),
        ],
      ),
    );
  }
}
