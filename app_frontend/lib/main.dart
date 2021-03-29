import 'package:flutter/material.dart';
import './views/screens/auth_screen.dart';
import './contollers/authentication/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './views/screens/home_screen.dart';
import './views/widgets/loading_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import './contollers/symptoms/symptom_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
          child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                final signInProvider =
                    Provider.of<GoogleSignInProvider>(context);
                if (signInProvider.isSigningIn) {
                  return Center(child: LoadingWidget());
                } else if (snapshot.hasData) {
                  return ChangeNotifierProvider(
                      create: (context) => SymptomProvider(),
                      child: HomeScreen());
                } else {
                  return AuthScreen();
                }
              }),
        ));
  }
}
