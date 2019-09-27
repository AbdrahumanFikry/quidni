import '../widgets/wishListItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishList.dart' show WishList;

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<WishList>(context).fetchData().then((_) {});
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final wishList = Provider.of<WishList>(context).items;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Wishist',
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text(
                          'Are you sure ?',
                          style: TextStyle(color: Colors.blue),
                        ),
                        content: Text('Do you want to clear wish list?'),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text('No')),
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Provider.of<WishList>(context)
                                    .removeAllFromWishList();
                              },
                              child: Text('Yes')),
                        ],
                      ));
            },
            color: Colors.white,
            child: Text(
              'Clear All',
              style: TextStyle(
                  color: Theme.of(context).accentColor, fontSize: 14.0),
            ),
          ),
        ],
      ),
      body: wishList.length == 0
          ? RefreshIndicator(
              onRefresh: () => Provider.of<WishList>(context).fetchData(),
              child: Center(
                child: Text(
                  'Yout wishlist is empty',
                  style: TextStyle(color: Colors.grey[500], fontSize: 16.0),
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: () => Provider.of<WishList>(context).fetchData(),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 30.0,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Swipe left to delete items',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: wishList.length,
                        itemBuilder: (context, index) {
                          return WishListItem(
                            id: wishList[index].id,
                            pid: wishList[index].id,
                            title: wishList[index].title,
                            image: wishList[index].image,
                            desc: wishList[index].description,
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
