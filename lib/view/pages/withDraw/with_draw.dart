import 'package:flutter/material.dart';
import 'package:freelance_app/models/transation.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/withDraw/widgets.dart';
import 'package:freelance_app/view/widgets/appbar.dart';
import 'package:freelance_app/view/widgets/back_button.dart';

class WithDrawPage extends StatelessWidget {

  static List transactions=[
  Trasaction(
    amount: "105.00",
    date: 'May 4 2020',
    reciever: "Paypal",
    type: 'Income Fundes',
    sent: false
  ),
  Trasaction(
    amount: "105.00",
    date: 'May 4 2020',
    reciever: "Macdonalds",
    type: 'Resturant',
    sent: true
  ),
  Trasaction(
    amount: "105.00",
    date: 'May 4 2020',
    reciever: "Paypal",
    type: 'Income Fundes',
    sent: false
  ),

  ];
  const WithDrawPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomBackButton(),
                BalanceWidget(
                  balance: "1,450 ",
                  accountNo: "1234567890",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    'assets/images/edit.png',
                    width: 30,
                    height: 30,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
                          child: Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: Dimensions.width(10),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Recent Transactions",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(0, 23, 49, 0.6)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                              textDirection: TextDirection.rtl,
                            )
                      ],
                    ),


                    Expanded(child: ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                      return RecentTransaction(

                        trasaction: transactions[index],
                      );
                     },
                    ),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
