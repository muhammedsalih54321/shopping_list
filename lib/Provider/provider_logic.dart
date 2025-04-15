import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:shopping_list/models/shopping_list.dart';

class ShoppingListProvider extends ChangeNotifier {
  final Box<ShoppingList> _shoppingBox = Hive.box<ShoppingList>(
    'shoppingLists',
  );

 
  List<ShoppingList> get allLists => _shoppingBox.values.toList();

  // ✅ Optional alias to match your UI call
  List<ShoppingList> get shoppingLists => allLists;

  void addShoppingList(ShoppingList list) {
    _shoppingBox.add(list);
    notifyListeners();
  }

  void deleteList(int index) {
    _shoppingBox.deleteAt(index);
    notifyListeners();
  }

  void updateShoppingList(ShoppingList oldList, ShoppingList updatedList) {
    final key = _shoppingBox.keys.firstWhere(
      (k) => _shoppingBox.get(k) == oldList,
      orElse: () => null,
    );

    if (key != null) {
      _shoppingBox.put(key, updatedList);
      notifyListeners();
    }
  }

  void clearAll() {
    _shoppingBox.clear();
    notifyListeners();
  }
}
