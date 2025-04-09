import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list/UI/Popular_product_screen.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryName;
  final String categoryimage;
  final List<String> products;
  final VoidCallback onBack;
  final Function onSelectedProductsChanged;

  const CategoryProductsScreen({
    Key? key,
    required this.categoryName,
    required this.products,
    required this.onBack,
    required this.categoryimage,
    required this.onSelectedProductsChanged,
  }) : super(key: key);

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
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
          onPressed: widget.onBack,
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
                child: Center(child: Image.asset(widget.categoryimage)),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          final product = widget.products[index];
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
              widget.products[index],
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
    );
  }
}
