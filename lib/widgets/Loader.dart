import 'package:beyond_wallet/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SpinKitFoldingCube(
            color: primaryColor,
            size: 50.0,
          ),
        ),
      ),

    );
  }
}
