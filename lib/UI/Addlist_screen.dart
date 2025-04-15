import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/Provider/provider_logic.dart';
import 'package:shopping_list/UI/Addproducts_list.dart';

class AddlistScreen extends StatefulWidget {
  const AddlistScreen({super.key});

  @override
  State<AddlistScreen> createState() => _AddlistScreenState();
}

class _AddlistScreenState extends State<AddlistScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<String> Suggestions = [
    'Shopping',
    'Groceries',
    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
    'Weekend',
    'Monday',
    'Trip',
    'Supermarket',
    'House',
    'Pharmacy',
    'Food',
  ];

  @override
  Widget build(BuildContext context) {
    final shoppingListProvider = Provider.of<ShoppingListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextButton(
          onPressed: () {
            Navigator.pop(context);
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
        actions: [
          TextButton(
            onPressed: () {
                String inputTitle = _controller.text.trim();

              if (inputTitle.isEmpty) {
                _showSnackBar('Please enter a list title');
                return;
              }

              final titleExists = shoppingListProvider.shoppingLists
                  .any((list) => list.title == inputTitle);

              if (titleExists) {
                _showSnackBar('This title is already used, please choose a new one');
                return;
              }

              // Navigate if title is unique
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => AddproductsList(listname: inputTitle),
                ),
              );
            },
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
          title: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              'Add List',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "New list",
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              Divider(),
              SizedBox(height: 10.h),
              Text(
                'Suggestions',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,

                  letterSpacing: -1,
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 30.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Suggestions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 6.w),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _controller.text = Suggestions[index];
                          });
                        },
                        child: Container(
                          height: 30.h,
                          width: Suggestions[index].length * 12.0.w,
                          decoration: BoxDecoration(
                            color: Color(0xFF5856D6),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Center(
                            child: Text(
                              Suggestions[index],
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF5856D6),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {},
        ),
        content: Text(
          message,
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
  }
}
