import 'package:flutter/material.dart';
import '../widgets/itemGrid.dart';
import 'package:provider/provider.dart';
import '../providers/itemsProvider.dart';

class SubCategoryScreen extends StatelessWidget {
  final String catId;
  final String catTitle;

  SubCategoryScreen({@required this.catId, @required this.catTitle});

  Future<void> _refreshPage(BuildContext context) {
    return Provider.of<Items>(context).fetchSubData(catTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).accentColor),
            onPressed: () => Navigator.of(context).pop()),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.tune,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {}),
        ],
        centerTitle: true,
        title: Text(
          catTitle,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<Items>(context,listen: false).fetchSubData(catTitle),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (data.error != null) {
              return Center(
                child: Text('An error occurred !'),
              );
            } else {
              return Consumer<Items>(
                builder: (context, items, child) => RefreshIndicator(
                  onRefresh: () => _refreshPage(context),
                  child: ItemGrid(),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
