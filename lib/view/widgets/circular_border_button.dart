import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';

class RoundedCornerButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final double width;
  final Color color;
  const RoundedCornerButton({
    Key key,
    @required this.text,
    @required this.onPress,
    @required this.width, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: Dimensions.height(6),
      child: RaisedButton(
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
        ),
        color: color??primary,
      ),
    );
  }
}
