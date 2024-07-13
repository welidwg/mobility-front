import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobility/Components/Navbars/BottomBar.dart';
import 'package:mobility/MainApp/CalculationScreen.dart';
import 'package:mobility/MainApp/Components/Header.dart';
import 'package:mobility/MainApp/PerformanceScreen.dart';
import 'package:mobility/constants/constants.dart';


class MainAuthScreen extends StatefulWidget {
   MainAuthScreen({super.key,this.current});
   Widget? current;

  static const String id = "main_Auth_screen";

  @override
  State<MainAuthScreen> createState() => _MainAuthScreenState();
}

class _MainAuthScreenState extends State<MainAuthScreen> {
  late Widget _current = widget.current== null ? const CalculationScreen() : widget.current!;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  setPage(Widget screen){
    setState(() {
      _current=screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kPrimaryColor,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          children: [
            const Header(),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: _current,
                ),
              ),
            ),
             BottomBar(current: _current,setPage: setPage,),
          ],
        ),
      )),
    );
  }
}
