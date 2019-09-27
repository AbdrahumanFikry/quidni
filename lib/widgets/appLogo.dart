import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.17,
          bottom: MediaQuery.of(context).size.height * 0.08),
      child: Text(
        "Qaidny",
        style: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor),
      ),
    );
  }
}
