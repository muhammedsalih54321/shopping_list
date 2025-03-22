import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list/UI/Addlist_screen.dart';

class Listscreen extends StatefulWidget {
  const Listscreen({super.key});

  @override
  State<Listscreen> createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {
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
                    backgroundColor: Color(0xFF007AFF),
                    foregroundColor: Colors.white,
                    icon: BootstrapIcons.share,
                    label: 'Share',
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
                            IconButton(
                              onPressed: () {
                                _Bottomsheet(context);
                              },
                              icon: Icon(BootstrapIcons.three_dots_vertical),
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

Future _Bottomsheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (
          BuildContext context,
          void Function(void Function()) setState,
        ) {
          return Container(
            height: 300.h,
            width: double.infinity.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              color: const Color.fromARGB(255, 62, 62, 62),
            ),

            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          'Manage List',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.29.h,
                            letterSpacing: -0.41,
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            BootstrapIcons.x_circle,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 45.h),
                    Row(
                      children: [
                        SizedBox(width: 18.w),
                        Icon(BootstrapIcons.pencil_fill, color: Colors.white),
                        SizedBox(width: 30.w),
                        Text(
                          'Rename',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.29.h,
                            letterSpacing: -0.41,
                          ),
                        ),
                      ],
                    ),
                     SizedBox(height: 30.h),
                    Row(
                      children: [
                        SizedBox(width: 18.w),
                        Icon(BootstrapIcons.share, color: Colors.white),
                        SizedBox(width: 30.w),
                        Text(
                          'Share',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.29.h,
                            letterSpacing: -0.41,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        SizedBox(width: 18.w),
                        Icon(BootstrapIcons.trash3, color: Colors.red),
                        SizedBox(width: 30.w),
                        Text(
                          'Delete',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.29.h,
                            letterSpacing: -0.41,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
