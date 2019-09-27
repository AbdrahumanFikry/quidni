import 'package:flutter/material.dart';

class ShareItem extends StatelessWidget {
  final String user;
  final String image;

  ShareItem({@required this.user, @required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      color: Colors.white,
      padding: const EdgeInsets.all(7.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            onTap: () {},
            leading: CircleAvatar(
              radius: 14.0,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(image),
            ),
            title: Text(
              user,
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
            trailing: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('shareItem');
                }),
          ),
        ],
      ),
    );
  }
}
