import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './drawerElement.dart';
import '../providers/auth.dart';
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Theme.of(context).accentColor,
            width: double.infinity,
            height: 200.0,
            padding: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('images/full-bloom.png')),
                  title: Text('My Account',
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                )
              ],
            ),
          ),
          DrawerElement(
            name: 'Settings',
            icon: Icons.settings,
            action: () {},
          ),
          DrawerElement(
            name: 'Country',
            icon: Icons.location_searching,
            action: () {},
          ),
          DrawerElement(
            name: 'Contact Us',
            icon: Icons.mail_outline,
            action: () {},
          ),
          DrawerElement(
            name: 'About Us',
            icon: Icons.info_outline,
            action: () {},
          ),
          DrawerElement(
            name: 'Logout',
            icon: Icons.exit_to_app,
            action: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context).logout();
            },
          ),
        ],
      ),
    );
  }
}
