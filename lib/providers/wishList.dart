import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WishItem {
  final String id;
  final String title;
  final String image;
  final String description;

  WishItem({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.description,
  });
}

class WishList with ChangeNotifier {
  final String authToken;
  final String userId;
  WishList(this.authToken,this.userId);

  List<WishItem> _items = [];

  List<WishItem> get items {
    return [..._items];
  }


  Future<void> addToWishList(
      String itemId, String title, String image, String description) async {
    final url =
        'https://quidni-5fb92.firebaseio.com/wishList/$userId.json?auth=$authToken';
    bool exist = _items.contains(title);
//    print(exist);
    try {
      if (!exist){
        await http.post(url,
            body: json.encode({
              'id': itemId,
              'title': title,
              'desc': description,
              'image': image,
            }));
        final newItem = WishItem(
          id: itemId,
          title: title,
          description: description,
          image: image,
        );
        _items.add((newItem));
        notifyListeners();
      }else{
       return;
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchData() async {
    final url =
        'https://quidni-5fb92.firebaseio.com/wishList/$userId.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final loadedData = json.decode(response.body) as Map<String, dynamic>;
      final List<WishItem> loadedItems = [];
      if(loadedData == null){
        return;
      }
      loadedData.forEach((itemId, itemData) {
        loadedItems.add(WishItem(
            id: itemId,
            title: itemData['title'],
            description: itemData['desc'],
            image: itemData['image']));
      });
      _items = loadedItems;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }


  Future<void> removeAllFromWishList() async {
    final url =
        'https://quidni-5fb92.firebaseio.com/wishList/$userId.json?auth=$authToken';
    await http.delete(url).then((_) {
      _items = [];
    }).catchError((error) {
      throw error;
    });
    _items = [];
    notifyListeners();
  }

  Future<void> removeFromWishList(String id) async {
    final url = 'https://quidni-5fb92.firebaseio.com/wishList/$userId/$id.json?auth=$authToken';
    try{
      final itemIndex = _items.indexWhere((item) => item.id == id);
      var item = _items[itemIndex];
      await http.delete(url).then((_) {
        item = null;
      }).catchError((error) {
        _items.insert(itemIndex, item);
        notifyListeners();
        print(error);
      });
      _items.removeAt(itemIndex);
      notifyListeners();
    }catch(error){
      print(error);
    }
  }

  int get itemsCount {
    return _items.length;
  }
}
