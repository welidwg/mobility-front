import 'package:flutter/cupertino.dart';
import 'package:mobility/Landing/Registration/FirstForm.dart';

class MainSignUp extends StatefulWidget {
   const MainSignUp({super.key,  this.setScreen});
  final Function? setScreen;
  static const String id = "main_signup_screen";


  @override
  State<MainSignUp> createState() => _MainSignUpState();
}

class _MainSignUpState extends State<MainSignUp> {
  late Widget _current=FirstForm(setScreen: setCurrent,);
  setCurrent(Widget screen){
    setState(() {
      _current=screen;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 40,
          left: 10,
          right: 10,
          child: Center(
              child: _current),
        )
      ],
    );
  }
}
