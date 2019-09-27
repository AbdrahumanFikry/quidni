import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/itemsProvider.dart';


class Post extends StatelessWidget {
  final String id;
  final String account;
  final String date;
  final String image;
  final String desc;
  final bool check;

  Post(
      {@required this.id,
      @required this.account,
      @required this.date,
      @required this.image,
      @required this.desc,
      @required this.check});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Container(
      margin: const EdgeInsets.only(right: 2.0, left: 2.0, top: 5.0),
      padding: const EdgeInsets.all(5.0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            onTap: () {},
            leading: CircleAvatar(
              radius: 22.0,
              backgroundColor: Theme.of(context).accentColor,
              backgroundImage: NetworkImage('https://virl.bc.ca/wp-content/uploads/2019/01/AccountIcon2.png'),
            ),
            trailing: !check
                ? Icon(
                    Icons.access_alarm,
                    color: Colors.blue,
                  )
                : PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    onSelected: (_) async {
                      try {
                        await Provider.of<Items>(context, listen: false)
                            .deleteItem(id);
                        scaffold.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Post deleted!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      } catch (error) {
                        scaffold.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Deleting failed!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('delete post'),
                        value: 0,
                      ),
                    ],
                  ),
            title: Text(
              account,
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
            subtitle: Text(date.toString()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
            child: Text(
              desc,
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
          ),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover)),
          ),
          check
              ? new Container(
                  width: double.infinity,
                  height: 5.0,
                  color: Colors.transparent,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.call,
                            color: Theme.of(context).accentColor),
                        label: Text('contact me')),
                    IconButton(
                      icon: Icon(Icons.favorite_border, color: Colors.red),
                      onPressed: () {
//                        wishList.addToWishList(
//                            item.id, item.title, item.image, item.description);
//                        Scaffold.of(context).hideCurrentSnackBar();
//                        Scaffold.of(context).showSnackBar(SnackBar(
//                          content: Text(
//                            'Added to ',
//                          ),
//                          duration: Duration(seconds: 2),
//                        ));
                      },
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
