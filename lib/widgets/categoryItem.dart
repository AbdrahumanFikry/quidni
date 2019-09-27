import 'package:demo/Screens/subCategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/caregory.dart';

class CatItem extends StatelessWidget {
//  final String id;
//  final String title;
//  final String image;
//
//  CatItem({@required this.id, @required this.title, @required this.image});
//
//  void _subCat(BuildContext context, String title, String id) {
//    Navigator.of(context)
//        .pushNamed('subCategoryScreen', arguments: {'id': id, 'title': title});
//  }

  @override
  Widget build(BuildContext context) {
    final categoryItem = Provider.of<Category>(context);
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SubCategoryScreen(
            catId: categoryItem.id,
            catTitle: categoryItem.title,
          ),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(categoryItem.image), fit: BoxFit.cover)),
          ),
          Positioned(
            bottom: 15.0,
            right: 10.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              color: Colors.black54,
              child: Text(categoryItem.title,
                  style: Theme.of(context).textTheme.title),
            ),
          ),
        ],
      ),
    );
  }
}
