import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobility/constants/constants.dart';

class CustomInput extends StatefulWidget {
  late String label;
  late String? value;
  late bool is_Password;
  late Widget? suffixIc;
  late bool? isTextArea = false;
  late bool? isNumber = false;
  late double? vPadding;
  late double? hPadding;
  final Function(String value) onChange;
  final Function? onTap;
  final String? message;
  bool? isEnabled = false;
  final TextEditingController? controller;

  CustomInput(
      {super.key,
        this.onTap,
        this.isEnabled,
        required this.label,
        required this.is_Password,
        required this.onChange,
        this.isTextArea,
        this.value,
        this.vPadding,
        this.hPadding,
        this.suffixIc,
        this.message,
        this.controller,
        this.isNumber});

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
      child: TextFormField(
        
        onTapOutside: (e) {
          FocusScope.of(context).unfocus();
        },
        enabled: widget.isEnabled,
        cursorColor: kPrimaryColor,
        controller: widget.controller,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return widget.message ?? "erreur";
          }
          return null;
        },
        maxLines: widget.isTextArea != null ? null : 1,
        obscureText: widget.is_Password,
        style: const TextStyle(
            color: kPrimaryColor,
            fontSize: 13,
            fontFamily: "Font1",
            fontWeight: FontWeight.bold),
        onChanged: (value) {
          widget.onChange(value);
          setState(() {});
        },
        onTap: () {
          widget.onTap != null ? widget.onTap!() : null;
        },
        keyboardType: widget.isTextArea != null
            ? TextInputType.multiline
            : widget.isNumber == true
            ? TextInputType.number
            : TextInputType.emailAddress,
        decoration: InputDecoration(
          focusColor: Colors.white,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: widget.suffixIc,
            suffixIconColor: kPrimaryColor,
            label: Text(widget.label,
                style: const TextStyle(
                    fontSize:  13,
                    color: Colors.grey,
                    fontFamily: "Font1")),
            alignLabelWithHint: true,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            hintStyle: const TextStyle(color: kPrimaryColor),
            contentPadding: EdgeInsets.symmetric(
                vertical: widget.vPadding == null ? 0.0 : widget.vPadding!,
                horizontal: widget.hPadding == null ? 20.0 : widget.hPadding!),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            errorStyle: const TextStyle(
                fontFamily: 'Font1',
                color: Colors.red,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
