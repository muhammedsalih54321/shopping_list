import 'package:hive/hive.dart';
import 'product.dart'; // If it includes Product

part 'shopping_list.g.dart'; // ✅ Important

@HiveType(typeId: 0)
class ShoppingList {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final List<Product> products;

  ShoppingList({required this.title, required this.products});
}
