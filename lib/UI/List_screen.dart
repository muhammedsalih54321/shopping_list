import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list/UI/Addlist_screen.dart';

class Listscreen extends StatefulWidget {
  const Listscreen({super.key});

  @override
  State<Listscreen> createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Lists',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 34.sp,
              fontWeight: FontWeight.w600,
              height: 1.21.h,
              letterSpacing: 0.40,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddlistScreen()),
                );
              },
              child: Text(
                'Add list',
                textAlign: TextAlign.right,
                style: GoogleFonts.poppins(
                  color: Color(0xFF5856D6),
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.29.h,
                  letterSpacing: -0.41,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: const Color.fromARGB(49, 154, 154, 154),
                ),

                width: 343.w,
                height: 100.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'To  buy later',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              height: 1.29.h,
                              letterSpacing: -0.41,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(BootstrapIcons.three_dots_vertical),
                          ),
                        ],
                      ),
                      Padding(
                        padding:  EdgeInsets.only(right: 17.w),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 10.h,
                              width: 280.w,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),color: Colors.greenAccent),
                            ),
                            Text(
                              '1/6',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.29.h,
                                letterSpacing: -0.41,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
