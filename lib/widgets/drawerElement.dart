import 'package:flutter/material.dart';

class DrawerElement extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function action;

  DrawerElement({@required this.name, @required this.icon,@required this.action});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: action,
      leading: Icon(icon, color: Colors.grey),
      title: Text(name,
          style: TextStyle(color: Colors.black, fontSize: 16.0)),
    );
  }
}
