import 'package:flutter/material.dart';
import 'package:freelance_app/models/order.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/payment/payment.dart';
import 'package:freelance_app/view/pages/payment/paymentnew.dart';
import 'package:freelance_app/view/widgets/appbar.dart';
import 'package:freelance_app/view/widgets/back_button.dart';
import 'package:freelance_app/view/widgets/circular_border_button.dart';
import 'package:freelance_app/view/widgets/text_field.dart';
import 'package:freelance_app/models/offers.dart';
import 'package:freelance_app/models/job.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:freelance_app/api/api.dart';

class ProgressPage extends StatelessWidget {
  final Offer data;
  final Job jobData;
  const ProgressPage({Key key, this.data, this.jobData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appbar(
        data.user_name==null?"user":data.user_name + "'s Offer",
        style:
            GoogleFonts.montserrat(fontWeight: FontWeight.w900, fontSize: 16),
        leading: CustomBackButton(),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
              hint: "",
              height: Dimensions.height(15),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: EdgeInsets.only(top: 20),
              child: Text(
                data.message,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            CustomTextField(
              hint: "",
//              height: Dimensions.height(10),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: EdgeInsets.only(top: 20),
              child: Text(
                data.specialize,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
//            CustomTextField(
//              hint: "",
//              height: Dimensions.height(8),
//              padding: const EdgeInsets.symmetric(
//                horizontal: 20,
//                vertical: 10,
//              ),
//              margin: EdgeInsets.only(top: 20, bottom: 20),
//              child: Center(
//                child: Text(
//                  "Job Type: Network troubleshooting",
//                  style: TextStyle(
//                    fontSize: 16,
//                    fontWeight: FontWeight.w600,
//                  ),
//                ),
//              ),
//            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  width: Dimensions.width(38),
                  suffix: Icon(Icons.monetization_on),
                  readOnly: true,
                  hint: data.offer_amount.toString(),
//                  text: data.offer_amount.toString(),
                ),
                SizedBox(
                  width: Dimensions.width(4),
                ),
                CustomTextField(
                  width: Dimensions.width(38),
                  suffix: Icon(Icons.timer),
                  readOnly: true,
                  hint: data.offer_time.toString(),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedCornerButton(
                  text: "Accept Offer",
                  onPress: ()  {
                    //Need to handle Json


                          //Future Link = Api().AcceptOffer();
                    String ID=data.id.toString();
                    //print(ID);
                    //var order=  Api().AcceptOffer(ID) as Order;
                    //print(order.url_payment);
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentPage(id: ID) //Paypal(id: ID
                        ),
                  );}


                  /*{
                    ProgressDialog pr = ProgressDialog(context,
                        type: ProgressDialogType.Normal,
                        isDismissible: false,
                        showLogs: false);

                    pr.style(
                        textAlign: TextAlign.left,
                        message: '  Updating Job .... ',
                        borderRadius: 0.5,
                        backgroundColor: Colors.white,
                        progressWidget: CircularProgressIndicator(
                          strokeWidth: 3,
                          backgroundColor: Colors.white,
                        ),
                        elevation: 1.0,
                        insetAnimCurve: Curves.easeInOut,
                        progress: 5.0,
                        maxProgress: 100.0,
                        progressTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w200),
                        messageTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600));
                    if (jobData.open)
                      pr.show().then((value) async {
                        //try {
                        Api().updateJob(jobData.id, data.user,data.id).then((value) {
                          pr.hide();
                          if (value)
                            Fluttertoast.showToast(
                                msg: "Job successfully updated",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          else
                            Fluttertoast.showToast(
                                msg: "Unable to upate job at the moment",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                        });
                      });
                    else
                      Fluttertoast.showToast(
                          msg: "Job is closed already",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                  }*/,
                  width: Dimensions.width(40),
                  color: primary,
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
