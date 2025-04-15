import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/Provider/provider_logic.dart';
import 'package:shopping_list/UI/Addlist_screen.dart';
import 'package:shopping_list/UI/Addproducts_list.dart';

class Listscreen extends StatefulWidget {
  const Listscreen({super.key});

  @override
  State<Listscreen> createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {
 
  @override
  Widget build(BuildContext context) {
    final shoppingProvider = Provider.of<ShoppingListProvider>(context);
    final lists = shoppingProvider.allLists;


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
                style: GoogleFonts.poppins(
                  color: const Color(0xFF5856D6),
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
        child:
            lists.isEmpty
                ? Center(
                  child: Text(
                    'No lists available',
                    style: GoogleFonts.poppins(fontSize: 16.sp),
                  ),
                )
                : ListView.builder(
                  itemCount: lists.length,
                  itemBuilder: (context, index) {
                    final list = lists[index];

                    return Slidable(
                      key: ValueKey(index),
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        dismissible: DismissiblePane(
                          onDismissed: () {
                            shoppingProvider.deleteList(index);
                          },
                        ),
                        children: [
                          SlidableAction(
                            autoClose: true,
                            borderRadius: BorderRadius.circular(15.r),
                            onPressed: (context) {
                              // TODO: Implement share
                            },
                            backgroundColor: const Color(0xFF007AFF),
                            foregroundColor: Colors.white,
                            icon: BootstrapIcons.share,
                            label: 'Share',
                          ),
                          SlidableAction(
                            autoClose: true,
                            borderRadius: BorderRadius.circular(15.r),
                            onPressed: (context) {
                              shoppingProvider.deleteList(index);
                            },
                            backgroundColor: const Color(0xFFF43425),
                            foregroundColor: Colors.white,
                            icon: BootstrapIcons.trash3,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) =>
                                        AddproductsList(listname: list.title),
                              ),
                            );
                          },
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        list.title,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _Bottomsheet(context);
                                        },
                                        icon: const Icon(
                                          BootstrapIcons.three_dots_vertical,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 17.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 10.h,
                                          width: 280.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20.r,
                                            ),
                                            color: Colors.greenAccent,
                                          ),
                                        ),
                                        Text(
                                          '${list.products.length}',
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w500,
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
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        _RenameBottomsheet(context);
                      },
                      child: Row(
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
                    InkWell(
                      onTap: () {
                        // shoppingProvider.deleteList(index);
                      },
                      child: Row(
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

Future _RenameBottomsheet(BuildContext context) {
  final updatecontroller = TextEditingController();

  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (
          BuildContext context,
          void Function(void Function()) setState,
        ) {
          return Container(
            height: 250.h,
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
                          'Rename List',
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
                    SizedBox(height: 35.h),
                    Container(
                      width: 375.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(74, 193, 191, 191),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: TextFormField(
                        controller: updatecontroller,
                        decoration: InputDecoration(
                          hintText: "Add Product",
                          hintStyle: GoogleFonts.poppins(
                            color: Color(0xFF8E8E93),
                            fontSize: 15.sp,

                            fontWeight: FontWeight.w300,
                          ),
                        
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),

                    InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 170.w,
                            height: 50.h,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color.fromARGB(255, 98, 97, 97),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  const Color.fromARGB(255, 98, 97, 97),
                                ),
                              ),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),

                          Container(
                            width: 170.w,
                            height: 50.h,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Color(0xFF5856D6),

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Color(0xFF5856D6),
                                ),
                              ),
                              child: Text(
                                "Save",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
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
