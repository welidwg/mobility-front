import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobility/Components/Buttons/BottomBarButton.dart';
import 'package:mobility/MainApp/CalculationScreen.dart';
import 'package:mobility/MainApp/PerformanceScreen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key, required this.current, required this.setPage});
  final Function setPage;

  final Widget current;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 11, 0, 5),
      padding: const EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
          color: CupertinoColors.inactiveGray,
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomBarButton(isActive: widget.current.runtimeType== CalculationScreen,onClick: (){
            widget.setPage(const CalculationScreen());
          },label: "Calculator",icon: Icons.calculate_outlined,),
          BottomBarButton(isActive: widget.current.runtimeType==PerformanceScreen,onClick: (){
            widget.setPage(const PerformanceScreen());
          },label: "Performance",icon: Icons.transfer_within_a_station_sharp,),
        ],
      ),
    );
  }
}
