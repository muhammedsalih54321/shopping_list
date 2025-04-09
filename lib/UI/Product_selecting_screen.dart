import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shopping_list/Components/allproducts_list.dart';
import 'package:shopping_list/UI/Popular_product_screen.dart';
import 'package:shopping_list/UI/categories_product_screen.dart';
import 'package:shopping_list/UI/catelog_screen.dart';

class ProductSelectingScreen extends StatefulWidget {
  final String listname;
  const ProductSelectingScreen({super.key, required this.listname});

  @override
  State<ProductSelectingScreen> createState() => _ProductSelectingScreenState();
}

class _ProductSelectingScreenState extends State<ProductSelectingScreen> {
  final searchcontroller = TextEditingController();
  late Box shoppingListBox;
  bool isSearching = false;
  List<String> allProducts = [];
  bool isNewPage = false;
  Map<String, dynamic>? selectedCategory; // Store selected category

  @override
  void initState() {
    super.initState();
   // Call the function to open the Hive box
    allProductslist;
  }

 

  void navigateToNewPage(Map<String, dynamic> category) {
    setState(() {
      isNewPage = true;
      selectedCategory = category; // Store selected category
    });
  }

  void goBackToHome() {
    setState(() {
      isNewPage = false;
      selectedCategory = null; // Reset selected category
    });
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

  void _updateSelectedProducts() {
    setState(() {}); // Rebuild screen when `selectedProducts` changes
  }

  // new
  List<String> getFilteredProducts(String query) {
    return allProductslist
        .where((product) => product.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TextButton.icon(
            icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF5856D6)),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                selectedProducts.clear();
              });
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
                  setState(() {
                    isSearching = query.trim().isNotEmpty;
                  });
                },
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            isSearching
                ? SizedBox()
                : TabBar(
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
                  isSearching
                      ? buildSearchResults()
                      : TabBarView(
                        children: [
                          PopularProductsScreen(
                            addProduct: addProduct,
                            onSelectedProductsChanged: _updateSelectedProducts,
                          ),
                          isNewPage && selectedCategory != null
                              ? CategoryProductsScreen(
                                onBack: goBackToHome,
                                categoryName:
                                    selectedCategory!['name'], // Pass selected category
                                products: selectedCategory!['products'],
                                categoryimage: selectedCategory!['image'],
                                onSelectedProductsChanged:
                                    _updateSelectedProducts, // Pass selected products
                              )
                              : CatalogScreen(
                                onNavigate: navigateToNewPage,
                              ), // Pass navigate function
                        ],
                      ),
            ),
          ],
        ),
        floatingActionButton:
            selectedProducts.isNotEmpty
                ? FloatingActionButton(
                  backgroundColor: Color(0xFF5856D6),
                  child: Icon(Icons.check, color: Colors.white),
                  onPressed: () {
                  
                    print(selectedProducts);
                  },
                )
                : null,
      ),
    );
  }

  Widget buildSearchResults() {
    final query = searchcontroller.text.trim();
    final filtered = getFilteredProducts(query);

    return Column(
      children: [
        Expanded(
          child:
              filtered.isNotEmpty
                  ? ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final product = filtered[index];
                      final isSelected = selectedProducts.containsKey(product);
                      final quantity = selectedProducts[product] ?? 0;
                      return ListTile(
                        leading: InkWell(
                          onTap: () {
                            setState(() {
                              selectedProducts[product] =
                                  (selectedProducts[product] ?? 0) + 1;

                              // widget.onSelectedProductsChanged();
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
                                  // widget.onSelectedProductsChanged();
                                },
                              ),
                          ],
                        ),
                      );
                    },
                  )
                  : Center(
                    child: Text(
                      '“$query” not found.\nYou can still add it manually.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 16.sp),
                    ),
                  ),
        ),
      ],
    );
  }
}
