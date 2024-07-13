import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  PrimaryButton(
      {super.key,
      required this.label,
      required this.onClick,
      this.icon,
      required this.color});

  final String label;
  final Function onClick;
  final Color color;
  Icon? icon;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          widget.onClick();
        },
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            side: MaterialStateProperty.all(BorderSide(
              color: widget.color==Colors.transparent ? Colors.white : widget.color,
            ),),
            backgroundColor: MaterialStateProperty.all(widget.color),
            padding: MaterialStateProperty.all(const EdgeInsets.all(17))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon != null ? widget.icon! : const SizedBox.shrink(),
            Text(
              widget.label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            )
          ],
        ));
  }
}
