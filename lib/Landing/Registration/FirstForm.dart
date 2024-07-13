import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobility/Components/Buttons/PrimaryButton.dart';
import 'package:mobility/Components/Inputs/CustomInput.dart';
import 'package:mobility/Landing/Registration/SecondForm.dart';

class FirstForm extends StatefulWidget {
  const FirstForm({super.key, required this.setScreen});

  final Function setScreen;

  @override
  State<FirstForm> createState() => _FirstFormState();
}

class _FirstFormState extends State<FirstForm> {
  TextEditingController name = TextEditingController(text: "");
  TextEditingController surname = TextEditingController(text: "");
  TextEditingController email = TextEditingController(text: "");
  TextEditingController age = TextEditingController(text: "");

  setData() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      name = TextEditingController(
          text: user!.displayName!.split(" ")[0].toString());
      surname = TextEditingController(
          text: user.displayName!.split(" ")[1].toString());
      email = TextEditingController(text: user.email);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "How should we call you?",
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
            "You can choose whatever name you want. We'll keep it just between you and us.",
            style:
                TextStyle(color: Colors.white54, height: 1.5, letterSpacing: 1),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 50,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomInput(
                    label: "My name is ..",
                    is_Password: false,
                    onChange: (value) {},
                    controller: name,
                  ),
                  CustomInput(
                    label: "My surname is ..",
                    is_Password: false,
                    onChange: (value) {},
                    controller: surname,
                  ),
                  CustomInput(
                    label: "My email address is ..",
                    is_Password: false,
                    onChange: (value) {},
                    controller: email,
                  ),
                  CustomInput(
                    label: "My age is ..",
                    is_Password: false,
                    message: "Please insert your age",
                    isNumber: true,
                    onChange: (value) {},
                    controller: age,
                  ),
                ],
              )),
          const SizedBox(
            height: 50,
          ),
          PrimaryButton(
            label: "Continue",
            onClick: () {
              if(_formKey.currentState!.validate()){
                widget.setScreen(SecondForm(
                  data: {
                    "age": age.text,
                    "name": name.text,
                    "surname": surname.text
                  },
                ));
              }

            },
            color: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}
