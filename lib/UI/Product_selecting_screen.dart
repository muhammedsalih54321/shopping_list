import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list/UI/Popular_product_screen.dart';
import 'package:shopping_list/UI/catelog_screen.dart';

class ProductSelectingScreen extends StatefulWidget {
  const ProductSelectingScreen({super.key});

  @override
  State<ProductSelectingScreen> createState() => _ProductSelectingScreenState();
}

class _ProductSelectingScreenState extends State<ProductSelectingScreen> {
  final searchcontroller = TextEditingController();

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
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Done',
                style: GoogleFonts.poppins(
                  color: Color(0xFF5856D6),
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.29.h,
                  letterSpacing: -0.41,
                ),
              ),
            ),
          ],
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
                  suffixIcon: Icon(
                    BootstrapIcons.mic_fill,
                    size: 20.sp,
                    color: Color(0xFF8E8E93),
                  ),

                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                onChanged: (query) {
                  setState(() {});
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
              child: TabBarView(
                children: [PopularProductsScreen(), CatalogScreen()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
