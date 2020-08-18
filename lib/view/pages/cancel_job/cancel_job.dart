import 'package:flutter/material.dart';

import '../../../utils/screen_dimensions_helper.dart';
import '../../../utils/screen_dimensions_helper.dart';
import '../../../utils/screen_dimensions_helper.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/circular_border_button.dart';
import '../../widgets/text_field.dart';

class CancelJob extends StatelessWidget {
  const CancelJob({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AuthHeader(
            title: "Cancel Job",
            bottomMargin: 20,
          ),
          Expanded(child: SizedBox()),
          CustomTextField(
            height: Dimensions.height(30),
            expandes: true,
            text: "Please write why you wan to canacel this Job",
          ),
          RoundedCornerButton(
            text: "Submit",
            onPress: () {},
            width: Dimensions.width(80),
            color: Color.fromRGBO(255, 95, 87, 1),
          ),
          SizedBox(
            height: Dimensions.height(20),
          )
        ],
      ),
    );
  }
}
