import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';

class JobDetailsWidget extends StatelessWidget {
  const JobDetailsWidget(
      {Key key, this.text1, this.text2, this.text3, this.text4})
      : super(key: key);
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimensions.height(10),
        width: Dimensions.width(80),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 12.5),
                blurRadius: 10,
                color: Color.fromRGBO(0, 0, 0, 0.01),
              ),
              BoxShadow(
                offset: Offset(0, 22.33),
                blurRadius: 17.869,
                color: Color.fromRGBO(0, 0, 0, 0.0119221),
              ),
              BoxShadow(
                offset: Offset(0, 100),
                blurRadius: 80,
                color: Color.fromRGBO(0, 0, 0, 0.02),
              )
            ]),
            padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  text1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  text2,
                  style: TextStyle(color: primary, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text(text3), Text(text4)],
            )
          ],
        ),
      ),
    );
  }
}
