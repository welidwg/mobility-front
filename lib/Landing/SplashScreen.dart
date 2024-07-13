import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobility/Auth/FireBaseUtils.dart';
import 'package:mobility/Landing/MainScreen.dart';
import 'package:mobility/Landing/Registration/MainSignUp.dart';
import 'package:mobility/MainApp/MainAuthScreen.dart';
import 'package:mobility/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String id = "splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool checkAuth = false;

  void checkAuthFunction() async {
    var user = await FireBaseUtils.verifyAuth();
    if (user == null) {
      Navigator.of(context).pushReplacementNamed(MainScreen.id);
    } else {
      bool isSaved=await FireBaseUtils.checkUserExisting(user);
      if(isSaved){
        Navigator.of(context).pushReplacementNamed(MainAuthScreen.id);
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>MainScreen(current: const MainSignUp(),)));
      }

    }
  }

  @override
  void initState() {
    super.initState();
    checkAuthFunction();
    Timer(const Duration(seconds: 3), () {
      if (!checkAuth) {
        Navigator.of(context).pushReplacementNamed(MainScreen.id);
      } else {
        Navigator.of(context).pushReplacementNamed(MainAuthScreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 4,
            ),
            Text(
              "Mobility Tracking App",
              style: GoogleFonts.alice(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
