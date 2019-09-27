import 'package:flutter/material.dart';

class Item with ChangeNotifier {
  final String id;
  final String catId;
  final String userId;
  final String title;
  final String description;
  final String image;
  final String date;

  Item({
    @required this.id,
    @required this.catId,
    @required this.userId,
    @required this.title,
    @required this.description,
    @required this.image,
    @required this.date,
  });
}
