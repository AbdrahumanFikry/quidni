import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              width: double.infinity,
              color: Theme.of(context).accentColor,
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35.0),
                  color: Colors.white,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Colors.blue,
                      hintText: 'Search..',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Your result will apper here ..',
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
