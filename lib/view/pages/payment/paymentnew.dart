import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/ask_for_help/ask_for_help.dart';
//import 'package:freelance_app/view/pages/payment/pay.dart';
import 'package:freelance_app/view/pages/payment/payment.dart';
import 'package:freelance_app/view/pages/payment/widgets.dart';
import 'package:freelance_app/view/widgets/appbar.dart';
import 'package:freelance_app/view/widgets/auth_header.dart';
import 'package:freelance_app/view/widgets/back_button.dart';
import 'package:freelance_app/view/widgets/circular_border_button.dart';
import 'package:freelance_app/view/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  final String id;
  const PaymentPage({Key key, this.id}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AuthHeader(title: "Payment"),
          Text("Pay with :",
              style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ).apply()),
          InkWell(
            onTap: () {
              print(widget.id);

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>   Paypal(id:widget.id),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 40, bottom: 40),
              width: Dimensions.width(80),
              height: Dimensions.height(10),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SvgPicture.asset(
                "assets/images/paypal.svg",
                color: Colors.white,
              ),
            ),
          ),
          Text("OR :",
              style: GoogleFonts.montserrat(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ).apply()),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AskForHelp(),
                ),
              );
            },
            child: Container(
                margin: const EdgeInsets.only(top: 40),
                width: Dimensions.width(80),
                height: Dimensions.height(10),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "Ask for Help",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 40,
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}

// CustomAppbar.appbar("Payment",
//           centerTitle: true, leading: CustomBackButton()),
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               height: 30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 InkWell(
//                   onTap: () => changePaymentMethod(0),
//                   child: PaymentMethods(
//                     image: 'credit',
//                     isActive: paymentMethodIndex == 0,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: InkWell(
//                     onTap: () => changePaymentMethod(1),
//                     child: PaymentMethods(
//                       image: 'money',
//                       isActive: paymentMethodIndex == 1,
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () => changePaymentMethod(2),
//                   child: PaymentMethods(
//                     image: 'master',
//                     isActive: paymentMethodIndex == 2,
//                   ),
//                 ),
//               ],
//             ),
//             CustomTextField(
//               margin: const EdgeInsets.only(top: 20),
//               child: DropdownButton(
//                 items: [],
//                 onChanged: (v) {},
//                 hint: Text(
//                   'Card',
//                   style: TextStyle(color: fontGreyColor, fontSize: 16),
//                 ),
//                 isExpanded: true,
//                 underline: Container(),
//               ),
//             ),
//             CustomTextField(
//               margin: const EdgeInsets.only(top: 20),
//               hint: "Card Number",
//             ),
//             CustomTextField(
//               margin: const EdgeInsets.only(top: 20),
//               hint: "Name",
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 CustomTextField(
//                   width: Dimensions.width(38),
//                   margin: const EdgeInsets.only(top: 20),
//                   suffix: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10
//                     ),
//                     child: Text(
//                       "Date",
//                       style: TextStyle(
//                         color: fontGreyColor,
//                       ),
//                     ),
//                   ),
//                   hint: "mm/yy",
//                 ),
//                 SizedBox(
//                   width: Dimensions.width(4),
//                 ),
//                 CustomTextField(
//                  suffix: Padding(
//                    padding: const EdgeInsets.symmetric(horizontal: 10),
//                    child: Text(
//                       "Date",
//                       style: TextStyle(
//                         color: fontGreyColor,
//                       ),
//                     ),
//                  ),
//                   width: Dimensions.width(38),
//                   margin: const EdgeInsets.only(top: 20),
//                   hint: "***",
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 100,
//             ),
//             RoundedCornerButton(
//               text: "Save",
//               onPress: () {},
//               width: Dimensions.width(60),
//             )
//           ],
//         ),
//       ),
