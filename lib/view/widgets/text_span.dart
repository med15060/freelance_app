import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:freelance_app/utils/colors.dart';

class CustomTextSpan extends StatelessWidget {
  final String text1;
  final String text2;
  final Function onTap;
  const CustomTextSpan({
    Key key,
    @required this.text1,
    @required this.text2,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        style: TextStyle(
            fontFamily: GoogleFonts.openSans().fontFamily, fontSize: 17),
        children: [
          TextSpan(
            text: text1,
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap =onTap,
            text: text2,
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.bold,
            ),
          )
        ]));
  }
}
