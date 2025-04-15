import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/Provider/productselecting_logic.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;
  final String categoryimage;
  final List<String> products;
  final VoidCallback onBack;

  const CategoryProductsScreen({
    Key? key,
    required this.categoryName,
    required this.products,
    required this.onBack,
    required this.categoryimage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductSelectionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            height: 1.29.h,
            letterSpacing: -0.41,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF5856D6)),
          onPressed: onBack,
          iconSize: 20.sp,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: ShapeDecoration(shape: OvalBorder()),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Image.asset(categoryimage)),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
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
    );
  }
}
