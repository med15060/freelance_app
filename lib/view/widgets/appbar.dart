import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar{
  static AppBar appbar(String title,{PreferredSize bottom,leading,bool centerTitle,TextStyle style,actions}){
    return  AppBar(

    actions: actions,
      leading: leading,
        centerTitle:centerTitle?? false,

        title: Text(title,

            style:style?? GoogleFonts.montserrat(
                fontWeight: FontWeight.w900, fontSize: 30)),
        bottom: bottom);
  }
}
