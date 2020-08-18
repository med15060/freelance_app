import 'package:flutter/material.dart';
import 'package:freelance_app/api/api.dart';
import 'package:freelance_app/models/transation.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class BalanceWidget extends StatelessWidget {
  final String balance;
  final String accountNo;

  const BalanceWidget({
    Key key,
    @required this.balance,
    @required this.accountNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:FutureBuilder(
        future: Api().getSellerTransaction()
        , builder: (BuildContext context, AsyncSnapshot<List<Histoftransact>> snapshot)
    {

      return Container(

      width: Dimensions.width(40),
      height: Dimensions.width(40),
      decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.02),
                offset: Offset(0, 100),
                blurRadius: 80),
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.0119),
                offset: Offset(0, 22.34),
                blurRadius: 80),
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.01),
                offset: Offset(0, 12.53),
                blurRadius: 53)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("My balance",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.white)),
          SizedBox(
            height: 10,
          ),
          Text(r"$" + balance,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30)),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Account',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.white)),
              Text(accountNo.replaceRange(0, 6, "*******"),
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.white))
            ],
          ),
        ],
      ),
    );


    } ));



  }}


class RecentTransaction extends StatelessWidget {
  final Trasaction trasaction;
  const RecentTransaction({
    Key key,
    this.trasaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      width: Dimensions.width(80),
      height: Dimensions.height(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                trasaction.reciever,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                r"$" + trasaction.amount,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: trasaction.sent
                        ? Color.fromRGBO(255, 95, 87, 1)
                        : Color.fromRGBO(21, 213, 192, 1)),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                trasaction.type,
                style: TextStyle(
                    color: Color.fromRGBO(0, 23, 49, 0.6), fontSize: 13),
              ),
              Text(
                trasaction.date,
                style: TextStyle(
                    color: Color.fromRGBO(0, 23, 49, 0.6), fontSize: 13),
              )
            ],
          )
        ],
      ),
    );
  }
}
