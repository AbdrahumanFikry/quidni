import 'package:flutter/material.dart';

class SignUpWith extends StatelessWidget {
  final String txt;
  const SignUpWith({@required this.txt});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                splashColor: Color(0xFF3B5998),
                color: Color(0xff3B5998),
                child: new Row(
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        txt,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    new Expanded(
                      child: Container(),
                    ),
                    new Transform.translate(
                      offset: Offset(15.0, 0.0),
                      child: new Container(
                        padding: const EdgeInsets.all(5.0),
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(28.0)),
                          splashColor: Colors.white,
                          color: Colors.white,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff3b5998),
                          ),
                          onPressed: () => {},
                        ),
                      ),
                    )
                  ],
                ),
                onPressed: () => {},
              ),
            ),
          ],
        ),
      );
  }
}
