import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list/Components/Products_list.dart';

// Ensure this file exists

class CatalogScreen extends StatelessWidget {
  final Function(Map<String, dynamic>) onNavigate;

  const CatalogScreen({super.key, required this.onNavigate});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          leading: Container(
            width: 40.w,
            height: 40.h,
            decoration: ShapeDecoration(
              shape: OvalBorder(
                side: BorderSide(
                  width: 0.50.w,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Colors.black.withValues(alpha: 51),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Image.asset(category["image"])),
            ),
          ), // Placeholder icon
          title: Text(
            category["name"]!,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              height: 1.29.h,
              letterSpacing: -0.41,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: Colors.grey,
          ),
          onTap: () {
            onNavigate(categories[index]); // Pass selected category
          },
        );
      },
    );
  }
}
