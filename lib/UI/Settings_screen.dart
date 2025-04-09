import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar:AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Hello ✋',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 34.sp,
              fontWeight: FontWeight.w600,
              height: 1.21.h,
              letterSpacing: 0.40,
            ),
          ),
        ),
        body: Column(children: [
          
        ],),
      
    );
  }
}