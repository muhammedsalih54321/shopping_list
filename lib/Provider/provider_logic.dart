import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:shopping_list/models/shopping_list.dart';

class ShoppingListProvider extends ChangeNotifier {
  final Box<ShoppingList> _shoppingBox = Hive.box<ShoppingList>('shoppingLists');

  List<ShoppingList> get allLists => _shoppingBox.values.toList();

  void addShoppingList(ShoppingList list) {
    _shoppingBox.add(list);
    notifyListeners();
  }

  void deleteList(int index) {
    _shoppingBox.deleteAt(index);
    notifyListeners();
  }

  void updateList(int index, ShoppingList updatedList) {
    _shoppingBox.putAt(index, updatedList);
    notifyListeners();
  }

  void clearAll() {
    _shoppingBox.clear();
    notifyListeners();
  }
}
