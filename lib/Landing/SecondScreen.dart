import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobility/Auth/FireBaseUtils.dart';
import 'package:mobility/Components/Buttons/PrimaryButton.dart';
import 'package:mobility/Components/Loading/LoadingSpinner.dart';
import 'package:mobility/Landing/Registration/MainSignUp.dart';
import 'package:mobility/MainApp/MainAuthScreen.dart';
import 'package:mobility/constants/constants.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({super.key, required this.setScreen});

  final Function setScreen;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 40,
          left: 10,
          right: 10,
          child: Center(
              child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const Text(
                  "Log in or Sign up",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 30,
                      letterSpacing: 1),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Welcome to Betrun, First thing first log in or sign up so that we can begin.",
                  style: TextStyle(
                      color: Colors.white, height: 1.5, letterSpacing: 1),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                isLoading
                    ? const LoadingSpinner()
                    : PrimaryButton(
                        label: "Continue with Google",
                        onClick: () async {
                          setState(() {
                            isLoading=true;
                          });
                          await signInWithGoogle();
                          setState(() {
                            isLoading=false;
                          });
                        },
                        color: Colors.transparent,
                      ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          )),
        )
      ],
    );
  }

  signInWithGoogle() async {
    User? user = await FireBaseUtils.signInWithGoogle();
    if (user != null) {
      bool checkExisting = await FireBaseUtils.checkUserExisting(user);
      if (!checkExisting) {
        // await FireBaseUtils.storeUser(user);
        widget.setScreen(MainSignUp(setScreen: widget.setScreen));
      } else {
        if (mounted) {
          Navigator.pushReplacementNamed(context, MainAuthScreen.id);
        }
      }
    } else {
      print('Connexion échouée');
    }
  }
}
