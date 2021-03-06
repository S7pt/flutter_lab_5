import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan[100],
      child: Center(
        child: SpinKitCircle(
          color: Colors.cyan,
          size: 50.0,
        ),
      ),
    );
  }
}
