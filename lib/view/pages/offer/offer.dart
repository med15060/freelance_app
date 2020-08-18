import 'package:flutter/material.dart';
import 'package:freelance_app/view/pages/job/widgets.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_dimensions_helper.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/circular_border_button.dart';
import '../../widgets/text_field.dart';
import 'package:freelance_app/models/job.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:freelance_app/api/api.dart';
import 'package:freelance_app/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({Key key, this.data}) : super(key: key);
  final Job data;


  @override
  OfferPageState createState() => OfferPageState();
}

class OfferPageState extends State<OfferPage> {
  TextEditingController textEditingCtrlMessage = new TextEditingController();
  TextEditingController textEditingCtrlCost = new TextEditingController();
  TextEditingController textEditingCtrlTime = new TextEditingController();

  @override
  Widget build(BuildContext ac) {
    print(widget.data);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AuthHeader(
              title: (widget.data.title!=null)?widget.data.title:" ",
              bottomMargin: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Description",
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    widget.data.description,
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: Dimensions.height(5),
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) => Specialize(
                        color: Colors.white,
                        text: widget.data.specialize,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100,
//                      height: 30,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(color: Colors.grey, width: 0.25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.monetization_on),
                            Text(
                              widget.data.job_price,
                            )
                          ],
                        ),
                      ),
//                    CustomTextField(
//                      width: Dimensions.width(36),
//                      suffix:  Icon(Icons.monetization_on),
//                      hint: myUser.hourly_rate,
//                    ),
                      SizedBox(
                        width: Dimensions.width(4),
                      ),
                      Container(
                        width: 100,
//                      height: 30,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(color: Colors.grey, width: 0.25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.timer),
                            Text(
                              widget.data.job_hours,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: CustomTextField(
                      textEditingController: textEditingCtrlMessage,
                      width: Dimensions.width(90),
                      margin: const EdgeInsets.only(top: 20),
                      hint: "Your offer....",
                      expandes: true,
                      height: Dimensions.height(20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
//                      height: 30,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey, width: 0.25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Job Type: " + widget.data.job_type,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CustomTextField(
                        textEditingController: textEditingCtrlCost,
                        width: Dimensions.width(36),
                        suffix: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.monetization_on)),
                        hint: "Cost/H",
                      ),
                      CustomTextField(
                        textEditingController: textEditingCtrlTime,
                        width: Dimensions.width(36),
                        suffix: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.timer)),
                        hint: "Time",
                        numeric: true,
                      )
                    ],
                  ),
                  Center(
                    child: RoundedCornerButton(
                        text: "Submit",
                        onPress: () {
                          ProgressDialog pr = ProgressDialog(context,
                              type: ProgressDialogType.Normal,
                              isDismissible: false,
                              showLogs: false);

                          pr.style(
                              textAlign: TextAlign.left,
//                              message: '  ...',
                              message: " Submitting...",
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
                          if (double.tryParse(textEditingCtrlCost.text) !=
                                  null &&
                              int.tryParse(textEditingCtrlTime.text) != null &&
                              textEditingCtrlMessage.text != null)
                            pr.show().then((value) async {
                              Api()
                                  .submitOffer(
                                      widget.data.id,
                                      double.tryParse(textEditingCtrlCost.text),
                                      int.tryParse(textEditingCtrlTime.text),
                                      textEditingCtrlMessage.text
                                     )
                                  .then((value) {
                                pr.hide();
                                Fluttertoast.showToast(
                                    msg: value,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
//                              if(value)
                              });
                            });
                          else
                            Fluttertoast.showToast(
                                msg: "All field are required",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                        },
                        width: Dimensions.width(80)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel",
                            style: TextStyle(
                              color: primary,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
