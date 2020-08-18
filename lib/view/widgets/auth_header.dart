import 'package:flutter/material.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/widgets/back_button.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final double bottomMargin;
  const AuthHeader({
    Key key,
    @required this.title, this.bottomMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.height(10),
        bottom:bottomMargin?? Dimensions.height(8),
      ),
      child: Stack(
        children: <Widget>[
          CustomBackButton(),
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ],
      ),
    );
  }
}
