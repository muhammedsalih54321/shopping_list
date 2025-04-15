import 'package:flutter/material.dart';

class ShoppingListModel {
  final String title;
  Map<String, int> products;

  ShoppingListModel({
    required this.title,
    required this.products,
  });
}

class ProductSelectionProvider extends ChangeNotifier {
  bool isSearching = false;
  bool isNewPage = false;
  Map<String, dynamic>? selectedCategory;
  Map<String, int> selectedProducts = {};
  String searchQuery = '';

  List<ShoppingListModel> allLists = []; // 🟡 Your saved lists

  // 🔍 Search & Category Logic
  void toggleSearching(bool value) {
    isSearching = value;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    isSearching = query.isNotEmpty;
    notifyListeners();
  }

  void setSelectedCategory(Map<String, dynamic> category) {
    selectedCategory = category;
    isNewPage = true;
    notifyListeners();
  }

  void goBack() {
    selectedCategory = null;
    isNewPage = false;
    notifyListeners();
  }

  // ✅ Product Selection Logic
  void increaseProduct(String product) {
    selectedProducts[product] = (selectedProducts[product] ?? 0) + 1;
    notifyListeners();
  }

  void decreaseProduct(String product) {
    if (selectedProducts.containsKey(product)) {
      final current = selectedProducts[product]!;
      if (current > 1) {
        selectedProducts[product] = current - 1;
      } else {
        selectedProducts.remove(product);
      }
      notifyListeners();
    }
  }

  void removeProduct(String product) {
    selectedProducts.remove(product);
    notifyListeners();
  }

  void clearSelection() {
    selectedProducts.clear();
    isSearching = false;
    notifyListeners();
  }

  void updateSelectedProducts() {
    notifyListeners(); // Manual trigger if needed
  }

  // 🟣 Check if a product is selected
  bool isProductSelected(String product) {
    return selectedProducts.containsKey(product);
  }

  int getProductQuantity(String product) {
    return selectedProducts[product] ?? 0;
  }

  // ✅ Save selected products to a specific list
  void saveList(String listname) {
    final index = allLists.indexWhere((list) => list.title == listname);

    if (index != -1) {
      // 🟢 List exists – update products
      final existingList = allLists[index];

      selectedProducts.forEach((product, qty) {
        if (existingList.products.containsKey(product)) {
          existingList.products[product] =
              existingList.products[product]! + qty;
        } else {
          existingList.products[product] = qty;
        }
      });

      notifyListeners();
    } else {
      // 🔵 List doesn't exist – create new
      allLists.add(ShoppingListModel(
        title: listname,
        products: Map<String, int>.from(selectedProducts),
      ));

      notifyListeners();
    }

    // Optionally clear selectedProducts after saving
    clearSelection();
  }
}
