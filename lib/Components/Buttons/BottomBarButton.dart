import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBarButton extends StatefulWidget {
  const BottomBarButton(
      {super.key,
      required this.isActive,
      required this.onClick,
      required this.label,
      required this.icon});

  final bool isActive;
  final Function onClick;
  final String label;
  final IconData icon;

  @override
  State<BottomBarButton> createState() => _BottomBarButtonState();
}

class _BottomBarButtonState extends State<BottomBarButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor:
                widget.isActive ? Colors.white24 : Colors.transparent,
            elevation: 0),
        onPressed: () {
          widget.onClick();
        },
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 30,
            ),
            widget.isActive ? Text(widget.label) : SizedBox.shrink()
          ],
        ));
  }
}
