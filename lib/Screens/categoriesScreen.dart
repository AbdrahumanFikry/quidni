import 'package:demo/providers/categoriesProvider.dart';
import 'package:demo/widgets/categoryGrid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/mainDrawer.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context)=>Categories(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Qaidny',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: Builder(
              builder: ((context) {
                return IconButton(
                    icon: Icon(Icons.menu),
                    color: Theme.of(context).accentColor,
                    onPressed: () => Scaffold.of(context).openDrawer());
              }),
            ),
          ),
          drawer: MainDrawer(),
          body: CategoryGrid(),
      ),
    );
  }
}
