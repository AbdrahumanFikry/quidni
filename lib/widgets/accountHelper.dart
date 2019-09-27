import 'package:flutter/material.dart';

class AccountHelper extends StatelessWidget {
  final String txt;
  final String route;

  const AccountHelper({@required this.txt,@required this.route});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: FlatButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.only(left: 20.0),
                alignment: Alignment.center,
                child: Text(
                  txt,
                  style:
                  TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
              onPressed: () => Navigator.of(context).pushReplacementNamed(route),
            ),
          ),
        ],
      ),
    );
  }
}
