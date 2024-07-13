import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
          width: 25,height: 25, child: CircularProgressIndicator(color: Colors.redAccent,)),
    );
  }
}
