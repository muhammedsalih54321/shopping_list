import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list/UI/Product_selecting_screen.dart';

class AddproductsList extends StatefulWidget {
  final String listname;
  const AddproductsList({super.key, required this.listname});

  @override
  State<AddproductsList> createState() => _AddproductsListState();
}

class _AddproductsListState extends State<AddproductsList> {
  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(BootstrapIcons.circle, color:Color(0xFF5856D6),size: 20.sp,),
            ),
            title: Text(
              'Fish',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                height: 1.21.h,
                letterSpacing: 0.40,
              ),
            ) ,
            trailing:Text(
              '2',
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 110, 110, 110),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                height: 1.21.h,
                letterSpacing: 0.40,
              ),
            ) ,
          );
        },
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductSelectingScreen(listname: widget.listname,)),
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
