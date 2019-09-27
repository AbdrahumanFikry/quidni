import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item.dart';
import '../providers/wishList.dart';

class SubCategoryItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);
    final wishList = Provider.of<WishList>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('itemDetails', arguments: item.id);
        },
        child: GridTile(
          child: Image.network(
            item.image,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(
              item.title,
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.call,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () {}),
            trailing: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {
                  wishList.addToWishList(
                      item.id, item.title, item.image, item.description);
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Added to wishlist',
                    ),
                    duration: Duration(seconds: 2),
                  ));
                }),
          ),
        ),
      ),
    );
  }
}
