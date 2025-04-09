import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Map<String, int> selectedProducts = {};

class PopularProductsScreen extends StatefulWidget {
  final Function(String, String) addProduct;
  final Function onSelectedProductsChanged;

  const PopularProductsScreen({
    super.key,
    required this.addProduct,
    required this.onSelectedProductsChanged,
  });

  @override
  State<PopularProductsScreen> createState() => _PopularProductsScreenState();
}

class _PopularProductsScreenState extends State<PopularProductsScreen> {
  final List<String> popularProducts = [
    "Apple",
    "Avocado",
    "Coffee Beans",
    "Still Water",
    "Carrots",
    "Spinach(fresh)",
    "Jeans",
    "Sneakers",
    "Micellar Water",
    "Shapmo",
    "Aspririn",
    "Juice",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ListView.builder(
                itemCount: popularProducts.length,
                itemBuilder: (context, index) {
                  final product = popularProducts[index];
                  final isSelected = selectedProducts.containsKey(product);
                  final quantity = selectedProducts[product] ?? 0;
                  return ListTile(
                    leading: InkWell(
                      onTap: () {
                        setState(() {
                          selectedProducts[product] =
                              (selectedProducts[product] ?? 0) + 1;

                          widget.onSelectedProductsChanged();
                        });
                      },
                      child: Icon(
                        isSelected
                            ? BootstrapIcons.plus_circle_fill
                            : BootstrapIcons.plus_circle,
                        color: Colors.purple,
                        size: 30.sp,
                      ),
                    ),
                    title: Text(
                      product,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        height: 1.29.h,
                        letterSpacing: -0.41,
                      ),
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isSelected)
                          Text(
                            '$quantity',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.29.h,
                              letterSpacing: -0.41,
                            ),
                          ),
                        if (isSelected)
                          IconButton(
                            icon: Icon(
                              quantity > 1
                                  ? BootstrapIcons.dash
                                  : BootstrapIcons
                                      .x, // Show `-` if quantity > 1, else `X`
                              color: quantity > 1 ? Colors.red : Colors.red,
                              size: 30.sp,
                            ),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  selectedProducts[product] =
                                      quantity - 1; // Decrease quantity
                                } else {
                                  selectedProducts.remove(
                                    product,
                                  ); // Remove if quantity reaches 0
                                }
                              });
                              widget.onSelectedProductsChanged();
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      SizedBox(height: 20.h,)
      ],
    );
  }
}
