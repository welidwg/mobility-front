import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobility/Auth/FireBaseUtils.dart';
import 'package:mobility/Components/Buttons/PrimaryButton.dart';
import 'package:mobility/Components/Buttons/RadioButton.dart';
import 'package:mobility/Components/Inputs/CustomInput.dart';
import 'package:mobility/MainApp/MainAuthScreen.dart';

class SecondForm extends StatefulWidget {
  const SecondForm({super.key, required this.data});
  final Map<String,dynamic> data;

  @override
  State<SecondForm> createState() => _SecondFormState();
}

class _SecondFormState extends State<SecondForm> {
  int _selectedValue = 0;

  setGender(int index) {
    setState(() {
      _selectedValue = index;
      widget.data["gender"]=_selectedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "How do you identify yourself?",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "We ask this to make sure your journey is fun.",
            style:
                TextStyle(color: Colors.white54, height: 1.5, letterSpacing: 1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 80,
          ),
          Column(
            children: [
              CustomRadioButton(
                  setGender: setGender,
                  label: "Male",
                  index: 1,
                  selectedGender: _selectedValue),
              CustomRadioButton(
                  setGender: setGender,
                  label: "Female",
                  index: 2,
                  selectedGender: _selectedValue),
              CustomRadioButton(
                  setGender: setGender,
                  label: "Non-binary",
                  index: 3,
                  selectedGender: _selectedValue),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          PrimaryButton(
            label: "Continue",
            onClick: () async{
              //widget.setScreen();
              if(_selectedValue!=0){
                User? user = FirebaseAuth.instance.currentUser!;
                await FireBaseUtils.storeUser(user, widget.data);
                Navigator.pushReplacementNamed(context, MainAuthScreen.id);
              }else{

                //showDialog(context: context, builder: (context)=>const SnackBar(content: Text("Please choose your gender !")));
              }

            },
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}
