import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './subCategoryItem.dart';
import '../providers/itemsProvider.dart';

class ItemGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemsData = Provider.of<Items>(context);
    final items = itemsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(15.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider(
          builder: (context) => items[index],
          child: SubCategoryItem(
//              id: items[index].id,
//              title: items[index].title,
//              image: items[index].image
              ),
        );
      },
    );
  }
}
