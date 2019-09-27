import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'item.dart';

class Items with ChangeNotifier {
  List<Item> _items = [];
  final String authToken;
  final String userId;

  Items(
    this.authToken,
    this._items,
    this.userId,
  );

  Future<void> fetchData([bool filterByUser = false]) async {
    final filterString = filterByUser ? 'orderBy="uId"&equalTo="$userId"' : '';
    final url =
        'https://quidni-5fb92.firebaseio.com/items.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final loadedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Item> loadedItems = [];
      loadedData.forEach((itemId, itemData) {
        loadedItems.add(Item(
            id: itemId,
            catId: itemData['catId'],
            title: itemData['title'],
            description: itemData['desc'],
            image: itemData['image'],
            date: itemData['date'],
            userId: itemData['uId']));
      });
      _items = loadedItems;
      notifyListeners();
    } catch (error) {
//      print('Error........' + error);
      throw error;
    }
  }

  Future<void> addItem(Item item,String catId) async {
    final url =
        'https://quidni-5fb92.firebaseio.com/items.json?auth=$authToken';
    try {
      await http.post(url,
          body: json.encode({
            'uId': userId,
            'catId': catId,
            'title': item.title,
            'desc': item.description,
            'image': item.image,
            'date': DateFormat.yMMMd().format(DateTime.now()).toString(),
          }));
      final newItem = Item(
          id: item.id,
          catId: item.catId,
          title: item.title,
          description: item.description,
          image: item.image,
          date: item.date,
          userId: item.userId);
      _items.add(newItem);
      notifyListeners();
    } catch (error) {
//      print(error);
      throw error;
    }
  }

  Future<void> deleteItem(String id) async {
    final url =
        'https://quidni-5fb92.firebaseio.com/items/$id.json?auth=$authToken';
    final itemIndex = _items.indexWhere((item) => item.id == id);
    var item = _items[itemIndex];
    await http.delete(url).then((_) {
      item = null;
    }).catchError(() {
      _items.insert(itemIndex, item);
      notifyListeners();
    });
    _items.removeAt(itemIndex);
    notifyListeners();
  }

  List<Item> get items {
    return [..._items];
  }

  Item findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void updateProduct(String id, Item newItem) {
    final itemIndex = _items.indexWhere((item) => item.id == id);
    if (itemIndex >= 0) {
      _items[itemIndex] = newItem;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
  Future<void> fetchSubData(String catId) async {
    final url =
        'https://quidni-5fb92.firebaseio.com/items.json?auth=$authToken&orderBy="catId"&equalTo="$catId"';
    try {
      final response = await http.get(url);
      final loadedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Item> loadedItems = [];
      loadedData.forEach((itemId, itemData) {
        loadedItems.add(Item(
            id: itemId,
            catId: itemData['catId'],
            title: itemData['title'],
            description: itemData['desc'],
            image: itemData['image'],
            date: itemData['date'],
            userId: itemData['uId']));
      });
      _items = loadedItems;
      notifyListeners();
    } catch (error) {
//      print('Error........' + error);
      throw error;
    }
  }
}
