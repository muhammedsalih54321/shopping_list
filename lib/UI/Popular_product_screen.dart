import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/Provider/productselecting_logic.dart';


class PopularProductsScreen extends StatelessWidget {
  final Function(String, String) addProduct;

  const PopularProductsScreen({
    super.key,
    required this.addProduct,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductSelectionProvider>(context);

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

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: popularProducts.length,
            itemBuilder: (context, index) {
              final product = popularProducts[index];
              final isSelected = provider.isProductSelected(product);
              final quantity = provider.getProductQuantity(product);

              return ListTile(
                leading: InkWell(
                  onTap: () => provider.increaseProduct(product),
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
                              : BootstrapIcons.x,
                          color: Colors.red,
                          size: 30.sp,
                        ),
                        onPressed: () => provider.decreaseProduct(product),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
