import 'package:hive/hive.dart';

part 'product.g.dart'; // This must match the file name exactly

@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String unit;

  @HiveField(3)
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.unit,
    required this.quantity,
  });
}
