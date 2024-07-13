import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.red,
      highlightColor: Colors.yellow,
      child: const Text(
        'Loading...',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40.0,
          fontWeight:
          FontWeight.bold,
        ),
      ),
    );
  }
}
