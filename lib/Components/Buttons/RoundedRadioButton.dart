import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedRadioButton extends StatefulWidget {
  const RoundedRadioButton({super.key, required this.setMean, required this.icon, required this.index, required this.selectedMean});
  final Function setMean;
  final IconData icon;
  final int index;
  final int selectedMean;


  @override
  State<RoundedRadioButton> createState() => _RoundedRadioButtonState();
}

class _RoundedRadioButtonState extends State<RoundedRadioButton> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: FloatingActionButton(
          onPressed: () {
            widget.setMean(widget.index);
          },
          backgroundColor: widget.index==widget.selectedMean? Colors.redAccent : Colors.white,

          child: Icon(widget.icon,color: widget.index==widget.selectedMean ? Colors.white : Colors.black,)),
    );
  }
}
