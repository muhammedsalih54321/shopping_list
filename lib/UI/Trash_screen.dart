import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class TrashScreen extends StatefulWidget {
  const TrashScreen({super.key});

  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  List<String> title = [
    'To  buy later',
    'To  buy later',
    'To  buy later',
    'To  buy later',
    'To  buy later',
    'To  buy later',
    'To  buy later',
    'To  buy later',
    'To  buy later',
    'To  buy later',
  ];
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
            'Trash',
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView.builder(
          itemCount: title.length,
          itemBuilder: (context, index) {
            return Slidable(
              key: ValueKey(index),
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                dismissible: DismissiblePane(onDismissed: () {}),
                children: [
                  SlidableAction(
                    autoClose: true,
                    borderRadius: BorderRadius.circular(15.r),
                    onPressed: (context) {},
                    backgroundColor: Color(0xFF4CD964),
                    foregroundColor: Colors.white,
                    icon: BootstrapIcons.arrow_clockwise,
                    label: 'Restore',
                    padding: EdgeInsets.zero,
                  ),
                  SlidableAction(
                    autoClose: true,
                    borderRadius: BorderRadius.circular(15.r),
                    onPressed: (context) {},
                    backgroundColor: Color(0xFFF43425),
                    foregroundColor: Colors.white,
                    icon: BootstrapIcons.trash3,
                    label: 'Delete',
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),

              child: Padding(
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
                              title[index],
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
                        Padding(
                          padding: EdgeInsets.only(right: 17.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 10.h,
                                width: 280.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: Colors.greenAccent,
                                ),
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
                        ),
                      ],
                    ),
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
