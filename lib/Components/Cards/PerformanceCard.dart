import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PerformanceCard extends StatefulWidget {
  const PerformanceCard(
      {super.key,
      required this.icon,
      required this.travels,
      required this.mean});

  final IconData icon;
  final List<dynamic> travels;
  final int mean;

  @override
  State<PerformanceCard> createState() => _PerformanceCardState();
}

class _PerformanceCardState extends State<PerformanceCard> {
  int kms = 0;

  setKms(){
    widget.travels.forEach((element) {
      if(element["mean"]==widget.mean){
        kms+=int.parse(element["km"]);
      }
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setKms();
  }
  String setLabel() {
    switch (widget.mean) {
      case 1:
        return "By Car";
      case 2:
        return "By Bicycle";
      case 3:
        return "By Foot";
      case 4:
        return "By Bus";
      default:
        return "None";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(
                      widget.icon,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    setLabel(),
                    style: const TextStyle(
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
               Text(
                "${kms} KM",
                style: TextStyle(
                    color: CupertinoColors.destructiveRed,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(height: 2, color: Colors.white10),
      ],
    );
  }
}
