import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({super.key, required this.setGender, required this.label, required this.index, required this.selectedGender});
  final Function setGender;
  final String label;
  final int index;
  final int selectedGender;


  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  bool _choosen=false;
  setChoosen(){
    if(widget.index==widget.selectedGender){
      setState(() {
        _choosen=true;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setChoosen();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: ElevatedButton(
          onPressed: () {
            widget.setGender(widget.index);
          },
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(widget.index==widget.selectedGender? Colors.redAccent : Colors.white),
              padding: MaterialStateProperty.all(const EdgeInsets.all(14))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //widget.icon != null ? widget.icon! : const SizedBox.shrink(),
              Text(
                widget.label,
                style:  TextStyle(
                    color: widget.index==widget.selectedGender ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              )
            ],
          )),
    );
  }
}
