import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobility/Components/Buttons/PrimaryButton.dart';
import 'package:mobility/Landing/SecondScreen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key, required this.setScreen});
  final Function setScreen;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(11.0),
      child: Stack(
        children: [
          Positioned(
            bottom: 40,
            left: 10,
            right: 10,
            child: Center(
                child: Column(
                  children:  [
                    const  Text(
                      "HEY MY FRIEND",
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 30,letterSpacing: 3),
                    ),
                    const  SizedBox(height: 15,),
                    const Text(
                      "Bet on yourself, achieve your goals, win your money back and more.",
                      style: TextStyle(color: Colors.white,height: 1.5,letterSpacing: 2),textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50,),
                    PrimaryButton(label: "Get Started", onClick: (){
                      setScreen(SecondScreen(setScreen: setScreen));
                    },color: Colors.redAccent,),

                  ],
                )),
          )
        ],
      ),
    );
  }
}
