import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularProductsScreen extends StatelessWidget {
  final List<Map<String, String>> popularProducts = [
    {"name": "Apples", "category": "Fruits"},
    {"name": "Avocado", "category": "Fruits"},
    {"name": "Coffee Beans", "category": "Coffee, Tea & Cocoa"},
    {"name": "Still Water", "category": "Beverages"},
    {"name": "Carrots", "category": "Vegetables"},
    {"name": "Jeans", "category": "Clothes & Shoes"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: popularProducts.length,
      itemBuilder: (context, index) {
        final product = popularProducts[index];
        return ListTile(
          leading: const Icon(BootstrapIcons.plus_circle, color: Colors.purple),
          title: Text(
            product["name"]!,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              height: 1.29.h,
              letterSpacing: -0.41,
            ),
          ),
        
          onTap: () {
            // Action when product is clicked (if needed)
          },
        );
      },
    );
  }
}
