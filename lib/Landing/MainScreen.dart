import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobility/Components/Buttons/PrimaryButton.dart';
import 'package:mobility/Landing/FirstScreen.dart';

class MainScreen extends StatefulWidget {
   MainScreen({super.key,this.current});

  static const String id = "main_noAuth_screen";
  Widget? current;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Widget _current=widget.current!=null ? widget.current! :FirstScreen(setScreen: setScreen);

  setScreen(Widget screen){
    setState(() {
      _current=screen;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.jpg"), fit: BoxFit.cover)),
        child: _current
      ),
    );
  }
}
