import 'package:flutter/material.dart';
import 'caregory.dart';

class Categories with ChangeNotifier {
  List<Category> _categories = [
    Category(id: 'c1', title: 'Clothes', image: 'images/clothes.jpg'),
    Category(id: 'c2', title: 'Mobile & Tablet', image: 'images/Mobile.png'),
    Category(id: 'c3', title: 'Electronics', image: 'images/electronics.jpg'),
    Category(id: 'c4', title: 'Games', image: 'images/games.jpg'),
    Category(id: 'c5', title: 'Cars', image: 'images/cars.jpg'),
    Category(id: 'c6', title: 'Tools', image: 'images/tools.jpg'),
    Category(id: 'c7', title: 'Home', image: 'images/home.jpg'),
    Category(id: 'c8', title: 'Books', image: 'images/books.jpg'),
  ];

  List<Category> get categories {
    return [..._categories];
  }


}
