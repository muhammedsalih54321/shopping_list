import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryName;
  final List<String> products;

  const CategoryProductsScreen({
    Key? key,
    required this.categoryName,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 25.sp,
            fontWeight: FontWeight.w500,
            height: 1.29.h,
            letterSpacing: -0.41,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF5856D6)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(BootstrapIcons.plus_circle, color: Colors.purple),
            title: Text(
              products[index],
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                height: 1.29.h,
                letterSpacing: -0.41,
              ),
            ),
            onTap: () {
              // Handle adding product action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Color(0xFF5856D6),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(label: 'Dismiss', textColor:Colors.white,onPressed: (){}),
                  content: Text(
                    "${products[index]} added",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.29.h,
                      letterSpacing: -0.41,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
