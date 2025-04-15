import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/Components/allproducts_list.dart';
import 'package:shopping_list/Provider/productselecting_logic.dart';
import 'package:shopping_list/Provider/provider_logic.dart';
import 'package:shopping_list/UI/Popular_product_screen.dart';
import 'package:shopping_list/UI/categories_product_screen.dart';
import 'package:shopping_list/UI/catelog_screen.dart';
import 'package:shopping_list/models/product.dart';
import 'package:shopping_list/models/shopping_list.dart';

class ProductSelectingScreen extends StatefulWidget {
  final String listname;
  final ShoppingList? existingList;
  const ProductSelectingScreen({
    super.key,
    required this.listname,
    this.existingList,
  });

  @override
  State<ProductSelectingScreen> createState() => _ProductSelectingScreenState();
}

class _ProductSelectingScreenState extends State<ProductSelectingScreen> {
  final searchcontroller = TextEditingController();
  late Box shoppingListBox;

  @override
  void initState() {
    super.initState();
    // Call the function to open the Hive box
    allProductslist;
    if (widget.existingList != null) {
      final provider = context.read<ProductSelectionProvider>();
      for (var product in widget.existingList!.products) {
        provider.selectedProducts[product.name] = product.quantity;
      }
    }
  }

  void addProduct(String productName, String productQuantity) {
    List<dynamic> productsDynamic = shoppingListBox.get(
      'products',
      defaultValue: [],
    );
    List<String> products = List<String>.from(productsDynamic);

    if (!products.contains(productName)) {
      products.add(productName);
      products.add(productQuantity);
      shoppingListBox.put('products', products);
      setState(() {});
    }
  }

  // new
  List<String> getFilteredProducts(String query) {
    return allProductslist
        .where((product) => product.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductSelectionProvider>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextButton.icon(
            icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF5856D6)),
            onPressed: () {
              Navigator.pop(context);

              provider.isSearching = false;
            },
            label: Text(
              'Back',
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
            title: Container(
              width: 375.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: const Color.fromARGB(74, 193, 191, 191),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: TextFormField(
                controller: searchcontroller,
                decoration: InputDecoration(
                  hintText: "Add Product",
                  hintStyle: GoogleFonts.poppins(
                    color: Color(0xFF8E8E93),
                    fontSize: 15.sp,

                    fontWeight: FontWeight.w300,
                  ),
                  prefixIcon: Icon(
                    BootstrapIcons.search,
                    size: 20.sp,
                    color: Color(0xFF8E8E93),
                  ),

                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                onChanged: (query) {
                  provider.updateSearchQuery(query);
                },
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text(
                    'Popular',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.23.h,
                      letterSpacing: -0.08,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Catalog',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.23.h,
                      letterSpacing: -0.08,
                    ),
                  ),
                ),
              ],
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child:
                  provider.isSearching
                      ? buildSearchResults()
                      : TabBarView(
                        children: [
                          PopularProductsScreen(addProduct: addProduct),
                          provider.isNewPage &&
                                  provider.selectedCategory != null
                              ? CategoryProductsScreen(
                                onBack: provider.goBack,
                                categoryName:
                                    provider
                                        .selectedCategory!['name'], // Pass selected category
                                products:
                                    provider.selectedCategory!['products'],
                                categoryimage:
                                    provider.selectedCategory!['image'],
                                // Pass selected products
                              )
                              : CatalogScreen(
                                onNavigate:
                                    (category) =>
                                        provider.setSelectedCategory(category),
                              ), // Pass navigate function
                        ],
                      ),
            ),
          ],
        ),
        floatingActionButton:
            provider.selectedProducts.isNotEmpty
                ? FloatingActionButton(
                  backgroundColor: Color(0xFF5856D6),
                  child: Icon(Icons.check, color: Colors.white),
                  onPressed: () {
                    final convertedList =
                        provider.selectedProducts.entries.map((entry) {
                          return Product(
                            id: UniqueKey().toString(),
                            name: entry.key,
                            unit: provider.selectedProducts.length.toString(),
                            quantity: entry.value,
                          );
                        }).toList();

                    final newList = ShoppingList(
                      title: widget.listname,
                      products: convertedList,
                    );

                    final shoppingListProvider =
                        context.read<ShoppingListProvider>();

                    if (widget.existingList != null) {
                      shoppingListProvider.updateShoppingList(
                        widget.existingList!, // old list
                        newList, // updated one
                      );
                    } else {
                      shoppingListProvider.addShoppingList(newList);
                    }

                    Navigator.pop(context);
                    provider.clearSelection();
                  },
                )
                : null,
      ),
    );
  }

  Widget buildSearchResults() {
    final provider = context.read<ProductSelectionProvider>();
    final query = searchcontroller.text.trim();
    final filtered = getFilteredProducts(query);
    final isAlreadySelected = provider.selectedProducts.containsKey(query);

    return Column(
      children: [
        Expanded(
          child:
              filtered.isNotEmpty
                  ? ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final product = filtered[index];
                      final isSelected = provider.selectedProducts.containsKey(
                        product,
                      );
                      final quantity = provider.selectedProducts[product] ?? 0;
                      return ListTile(
                        leading: InkWell(
                          onTap: () {
                            provider.increaseProduct(product);
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
                                  if (quantity > 1) {
                                    provider.decreaseProduct(
                                      product,
                                    ); // Decrease quantity
                                  } else {
                                    provider.removeProduct(
                                      product,
                                    ); // Remove if quantity reaches 0
                                  }

                                  // widget.onSelectedProductsChanged();
                                },
                              ),
                          ],
                        ),
                      );
                    },
                  )
                  : Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFCF7FF),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// PLUS ICON (always shown)
                                InkWell(
                                  onTap: () {
                                    provider.increaseProduct(query);
                                    provider.updateSearchQuery(query);
                                    print(query);
                                  },
                                  child: Icon(
                                    isAlreadySelected
                                        ? BootstrapIcons.plus_circle_fill
                                        : BootstrapIcons.plus_circle,
                                    color: Colors.purple,
                                    size: 30.sp,
                                  ),
                                ),

                                /// Product name
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                    ),
                                    child: Text(
                                      query,
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),

                                /// Quantity + Decrease / Remove buttons
                                if (isAlreadySelected)
                                  Row(
                                    children: [
                                      /// Quantity text
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.w),
                                        child: Text(
                                          '${provider.selectedProducts[query]}',
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            height: 1.29.h,
                                            letterSpacing: -0.41,
                                          ),
                                        ),
                                      ),

                                      /// Decrease or Remove button
                                      InkWell(
                                        onTap: () {
                                          final quantity =
                                              provider.selectedProducts[query]!;
                                          if (quantity > 1) {
                                            provider.decreaseProduct(query);
                                          } else {
                                            provider.removeProduct(query);
                                          }
                                        },
                                        child: Icon(
                                          provider.selectedProducts[query]! > 1
                                              ? BootstrapIcons.dash
                                              : BootstrapIcons.x,
                                          color: Colors.red,
                                          size: 30.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
        ),
      ],
    );
  }
}
