import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './categoryItem.dart';
import '../providers/categoriesProvider.dart';
import '../widgets/categoryItem.dart';

class CategoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryData = Provider.of<Categories>(context);
    final categories = categoryData.categories;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        childAspectRatio: 3 / 2,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider(
          builder: (context)=> categories[index],
          child:  CatItem(
//          id: categories[index].id,
//          title: categories[index].title,
//          image: categories[index].image,
            ),
        );
      },
    );
  }
}
