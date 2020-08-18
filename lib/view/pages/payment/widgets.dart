import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';

class PaymentMethods extends StatelessWidget {
  final String image;
  final bool isActive;
  const PaymentMethods({Key key, this.image, this.isActive=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.width(25),
      height: Dimensions.height(6),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color:isActive?primary: Color.fromRGBO(0, 23, 49, 0.4), width: 1),
      ),
      child: SvgPicture.asset(
        'assets/images/$image.svg',
        color: isActive ? primary : Colors.grey,
        height: 30,
        width: 30,
      ),
    );
  }
}
