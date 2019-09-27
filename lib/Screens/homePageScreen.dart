import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishList.dart';
import '../widgets/badge.dart';
import './wishListScreen.dart';
import './categoriesScreen.dart';
import './timelineScreen.dart';
import './accountScreen.dart';
import './searchScreen.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<Object> _pages;
  int nIndex = 0;

  void _changeScreen(int val) {
    setState(() {
      nIndex = val;
    });
  }

  void initState() {
    _pages = [
      /*******Screens*******/
      CategoriesScreen(),
      SearchScreen(),
      AccountScreen(),
      WishListScreen(),
      TimeLineScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wishList = Provider.of<WishList>(context);
    return Scaffold(
      body: _pages[nIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: nIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _changeScreen,
          fixedColor: Theme.of(context).accentColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.apps), title: Text('Categories')),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('Search')),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), title: Text('My Account')),
            BottomNavigationBarItem(
                icon: wishList.items.isEmpty
                    ? Icon(Icons.favorite_border)
                    : Badge(
                        child: Icon(Icons.favorite_border),
                        color: Colors.red,
                        value: wishList.itemsCount.toString(),
                      ),
                title: Text('Wishlist')),
            BottomNavigationBarItem(
                icon: Icon(Icons.timeline), title: Text('Timeline')),
          ]),
    );
  }
}
