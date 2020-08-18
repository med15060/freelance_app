import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final Widget child;
  final Widget suffix;
  final EdgeInsets margin;
  final double height;
  final double width;
  final EdgeInsets padding;
  final Widget prefix;
  final String label;
  final bool expandes;
  final bool readOnly;
  final String text;
  final bool numeric;
  final double bottomMargin;
  final TextEditingController textEditingController;
  final bool obscure;
  const CustomTextField(
      {Key key,
      this.hint,
      this.child,
      this.suffix,
      this.margin,
      this.height,
      this.width,
      this.padding,
      this.prefix,
      this.text,
      this.label,
      this.expandes = false,
      this.numeric = false,
      this.readOnly = false,
      this.textEditingController,
      this.bottomMargin = 30,this.obscure=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        label != null
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(0, 23, 49, 0.4),
                  ),
                ),
              )
            : Container(),
        Center(
          child: Container(
              margin: margin ?? const EdgeInsets.only(bottom: 30),
              width: width ?? Dimensions.width(80),
              height: height ?? Dimensions.height(7),
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
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
              child: child ??
                  Row(
                    children: <Widget>[
                      suffix != null ? suffix : Container(),
                      Expanded(
                        child: TextField(
                          obscureText: obscure,
                          inputFormatters: numeric
                              ? <TextInputFormatter>[
                                  WhitelistingTextInputFormatter.digitsOnly
                                ]
                              : null,
                          keyboardType: numeric ? TextInputType.number : null,
                          controller: textEditingController,
                          readOnly: readOnly,
                          enabled: !readOnly,
                          expands: expandes,
                          maxLines: expandes ? null : 1,
                          style: TextStyle(color: fontColor),
                          decoration: InputDecoration(
//                              contentPadding:
//                                  const EdgeInsets.symmetric(vertical: 20),
                              border: InputBorder.none,
                              hintText: hint,
                              hintStyle:
                                  GoogleFonts.openSans(color: fontGreyColor)
                                      .apply()),
                        ),
                      ),
                      prefix != null ? prefix : Container(),
                    ],
                  )),
        ),
      ],
    );
  }
}

// suffixIcon: suffix != null ? Icon(suffix) : Container(),
//                 prefixIcon: prefix != null
//                     ? Icon(
//                         prefix,
//                         color: Colors.black,
//                       )
//                     : Container(),
