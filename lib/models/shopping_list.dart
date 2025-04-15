import 'package:hive/hive.dart';
import 'product.dart'; // Assuming you have this already
import 'package:uuid/uuid.dart';

part 'shopping_list.g.dart';

@HiveType(typeId: 0)
class ShoppingList extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<Product> products;

  ShoppingList({
    String? id,
    required this.title,
    required this.products,
  }) : id = id ?? const Uuid().v4(); // generate unique ID
}
