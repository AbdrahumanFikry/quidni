import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/itemsProvider.dart';
import '../providers/wishList.dart';

class ItemDetails extends StatefulWidget {
  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  String txt = 'Add to wishlist';

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context).settings.arguments as String;
    final itemData = Provider.of<Items>(context);
    final loadedItem = itemData.findById(itemId);
    final wishList = Provider.of<WishList>(context);
    void _onPressed() {
      wishList.addToWishList(
        loadedItem.id,
        loadedItem.title,
        loadedItem.image,
        loadedItem.description,
      );
      setState(() {
        txt = 'Added';
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).accentColor),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(loadedItem.title,
            style: TextStyle(color: Theme.of(context).accentColor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              width: double.infinity,
              height: 270,
              child: Image.network(
                loadedItem.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              width: double.infinity,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey[500],
                    width: 0.5,
                  )),
              child: Text(
                loadedItem.description,
                style: TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 14.0),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.call,
                    color: Colors.blue,
                  ),
                  label: Text(
                    'Contact me',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                FlatButton.icon(
                  onPressed: _onPressed,
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  label: Text(
                    txt,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
