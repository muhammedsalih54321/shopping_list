import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/Provider/productselecting_logic.dart';
import 'package:shopping_list/Provider/provider_logic.dart';
import 'package:shopping_list/UI/Product_selecting_screen.dart';
import 'package:shopping_list/models/shopping_list.dart';

class AddproductsList extends StatefulWidget {
  final String listname;

  const AddproductsList({super.key, required this.listname});

  @override
  State<AddproductsList> createState() => _AddproductsListState();
}

class _AddproductsListState extends State<AddproductsList> {
  @override
  Widget build(BuildContext context) {
    final providers = context.watch<ProductSelectionProvider>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextButton(
          onPressed: () {
            Navigator.pop(context);
            providers.clearSelection();
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(
              color: Color(0xFF5856D6),
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
              height: 1.29.h,
              letterSpacing: -0.41,
            ),
          ),
        ),

        bottom: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              widget.listname,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 34.sp,
                fontWeight: FontWeight.w600,
                height: 1.21.h,
                letterSpacing: 0.40,
              ),
            ),
          ),
        ),
      ),
      body: Consumer<ShoppingListProvider>(
        builder: (context, provider, _) {
          final matchingLists =
              provider.allLists
                  .where((l) => l.title == widget.listname)
                  .toList();

          if (matchingLists.isEmpty || matchingLists.first.products.isEmpty) {
            return Center(
              child: Text(
                'No products added yet.',
                style: GoogleFonts.poppins(fontSize: 16.sp),
              ),
            );
          }

          final products = matchingLists.first.products;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return ListTile(
                leading: Icon(
                  BootstrapIcons.circle,
                  color: Color(0xFF5856D6),
                  size: 20.sp,
                ),
                title: Text(
                  product.name.toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.21.h,
                    letterSpacing: 0.40,
                  ),
                ),
                trailing: Text(
                  product.quantity.toString(),
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 110, 110, 110),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.21.h,
                    letterSpacing: 0.40,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: InkWell(
        onTap: () {
          final shoppingListProvider = Provider.of<ShoppingListProvider>(
            context,
            listen: false,
          );
          final existingLists =
              shoppingListProvider.allLists
                  .where((l) => l.title == widget.listname)
                  .toList();

          ShoppingList shoppingList;

          if (existingLists.isNotEmpty) {
            // 🟢 List already exists — we're editing it
            shoppingList = existingLists.first;
          } else {
            // 🔵 New list — create and save it first
            shoppingList = ShoppingList(title: widget.listname, products: []);
            shoppingListProvider.addShoppingList(shoppingList);
          }

          // 🚀 Now navigate
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => ProductSelectingScreen(
                    listname: widget.listname,
                    existingList: shoppingList,
                  ),
            ),
          );
        },
        child: Container(
          height: 70.h,
          width: 120.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            color: Color(0xFF5856D6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(BootstrapIcons.plus, color: Colors.white, size: 35.sp),
              Text(
                'ADD',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 5.w),
            ],
          ),
        ),
      ),
    );
  }
}
