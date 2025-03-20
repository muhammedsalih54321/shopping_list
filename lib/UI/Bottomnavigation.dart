import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list/UI/List_screen.dart';
import 'package:shopping_list/UI/Settings_screen.dart';
import 'package:shopping_list/UI/Trash_screen.dart';


class BottomnavigationScreen extends StatefulWidget {
  const BottomnavigationScreen({super.key});

  @override
  State<BottomnavigationScreen> createState() => _BottomnavigationScreenState();
}

class _BottomnavigationScreenState extends State<BottomnavigationScreen> {
  final screen = [
    Listscreen(),
    TrashScreen(),
    SettingsScreen(),
  ];
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          iconSize: 25.sp,
          // ignore: deprecated_member_use
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF5856D6),
          showUnselectedLabels: true,
          unselectedItemColor: Color(0xFF616161),
          selectedLabelStyle: GoogleFonts.poppins(
            color: Color(0xFF5856D6),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
           
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
              color: Color(0xFF616161),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              ),
          currentIndex: currentindex,
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                BootstrapIcons.card_list,
              ),
              label: 'Lists',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  BootstrapIcons.trash3,
                ),
                label: 'Trash'),
                 BottomNavigationBarItem(
                icon: Icon(
                  BootstrapIcons.gear,
                ),
                label: 'Settings'),
          ]),
      // ),
      body: screen[currentindex],
      
    );
  }
}