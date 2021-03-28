import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupButton extends StatelessWidget {
  final Function onTap;
  final FaIcon iconToShow;
  final String text;
  SignupButton({this.iconToShow, this.onTap, this.text});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
   
      child: Card(
        
        elevation: 20.0,
        shape: StadiumBorder(),
        
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,    
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: iconToShow,
            ),
            Text(
                text,
                style: TextStyle(fontSize: 25.0),
            )
          ],
        ),
              ),
      ),
      onPressed: onTap,
    );

   
  }
}
