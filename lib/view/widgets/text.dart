import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/colors.dart';
import '../../utils/screen_dimensions_helper.dart';
import '../../utils/screen_dimensions_helper.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {Key key,
      this.width,
      this.height,
      this.text1,
      this.text2,
      this.margin,
      })
      : super(key: key);
  final double width;
  final double height;
  final String text1;
  final String text2;
  final EdgeInsets margin;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 30),
      width: width ?? Dimensions.width(80),
      
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.01),
              offset: Offset(0, 12),
              blurRadius: 10),
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.0119),
              offset: Offset(0, 22),
              blurRadius: 18),
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.02),
              offset: Offset(0, 100),
              blurRadius: 80)
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Text.rich(TextSpan(
          children: [
            text1 != null
                ? TextSpan(
                    text: text1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )
                  )
                :TextSpan(),
                   text2!=null? TextSpan(
                        text: text2,
                      )
                    : TextSpan(),
          ],
          style: TextStyle(
            
            color: fontColor,
          ))),
    );
  }
}
