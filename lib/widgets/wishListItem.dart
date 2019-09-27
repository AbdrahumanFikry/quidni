import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishList.dart' show WishList;

class WishListItem extends StatelessWidget {
  final String id;
  final String pid;
  final String title;
  final String image;
  final String desc;

  WishListItem({
    @required this.id,
    @required this.pid,
    @required this.title,
    @required this.image,
    @required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    'Are you sure ?',
                    style: TextStyle(color: Colors.blue),
                  ),
                  content:
                      Text('Do you want to remove this item from wish list?'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('No')),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Yes')),
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<WishList>(context, listen: false).removeFromWishList(id);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.all(7.0),
        padding: const EdgeInsets.only(right: 20.0),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30.0,
        ),
      ),
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        margin: const EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          child: ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('itemDetails',arguments: id);
            },
            title: Text(
              title,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 16.0,
              ),
            ),
            leading: Container(
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.cover),
              ),
            ),
            subtitle: Text(
              desc,
              style: TextStyle(
                color: Colors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
                icon: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('itemDetails', arguments: id);
                }),
          ),
        ),
      ),
    );
  }
}
