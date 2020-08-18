import 'dart:convert';
import 'package:freelance_app/main.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/create_job/widget.dart';
import 'package:freelance_app/view/pages/job/job.dart';
import 'package:freelance_app/view/widgets/appbar.dart';
import 'package:freelance_app/view/widgets/back_button.dart';
import 'package:freelance_app/view/widgets/circular_border_button.dart';
import 'package:freelance_app/view/widgets/text_field.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelance_app/api/api.dart';

class CreateJob extends StatefulWidget {
  const CreateJob({Key key}) : super(key: key);
  @override
  CreateJobState createState() => CreateJobState();
}

class CreateJobState extends State<CreateJob> {
  TextEditingController ctrlDescription = new TextEditingController();
  TextEditingController ctrlTitle = new TextEditingController();
  TextEditingController ctrlPay = new TextEditingController();
  TextEditingController ctrlAddress = new TextEditingController();
  TextEditingController ctrlSpecialize = new TextEditingController();
  TextEditingController ctrlJobPrice = new TextEditingController();
  TextEditingController ctrlJobHours = new TextEditingController();
  String jobType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctrlPay.text = "PayPal";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appbar(
        "Create Job",

        // leading: CustomBackButton(),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomTextField(
              textEditingController: ctrlTitle,
              margin: EdgeInsets.only(top: 20),
//              height: Dimensions.height(20),
              hint: "Title",
            ),
            CustomTextField(
              textEditingController: ctrlDescription,
              margin: EdgeInsets.only(top: 5),
              height: Dimensions.height(20),
              hint: "Description",
              expandes: true,
            ),
            CustomTextField(
              textEditingController: ctrlAddress,
              margin: EdgeInsets.only(top: 20),
              hint: "Address",
            ),
            CustomTextField(
              textEditingController: ctrlSpecialize,
              margin: EdgeInsets.only(top: 20),
              hint: "Specialize",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  textEditingController: ctrlPay,
                  readOnly: true,
                  width: Dimensions.width(36),
                  margin: EdgeInsets.only(top: 20),
                  hint: "Pay",
                ),
                SizedBox(
                  width: Dimensions.width(4),
                ),
                CustomTextField(
                  width: Dimensions.width(36),
                  margin: EdgeInsets.only(top: 20),
                  child: DropdownButton(
                    items: <String>[
                      'Remote',
                      'Commute',
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (v) {
                      setState(() {
                        jobType = v;
                      });
                    },
                    hint: Text('Job type'),
                    isExpanded: true,
                    underline: Container(),
                  ),
                ),
              ],
            ),

            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomTextField(
                    textEditingController: ctrlJobPrice,
                    width: Dimensions.width(36),
                    suffix: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.monetization_on)),
                    hint: "Cost",
                  ),
                  CustomTextField(
                    textEditingController: ctrlJobHours,
                    width: Dimensions.width(36),
                    suffix: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.timer)),
                    hint: "Time",
                    numeric: true,
                  )
                ],
              ),
            ),
//            CustomTextField(
////              margin: EdgeInsets.only(top: 20),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Text(
//                    'Upload File',
//                    style: TextStyle(
//                      color: fontGreyColor,
//                    ),
//                  ),
//                  Icon(
//                    Icons.file_upload,
//                    color: fontGreyColor,
//                  )
//                ],
//              ),
//            ),
//              width: Dimensions.width(80),
//              child: ListView.builder(
//                shrinkWrap: true,
//                itemCount: 1,
//                itemBuilder: (BuildContext context, int index) {
//                  return UploadedFileWidget(
//                    filename: 'Iphone_image.png',
//                  );
//                },
//              ),
//            ),
//            SizedBox(
//              height: Dimensions.height(10),
//            ),
            RoundedCornerButton(
              text: "Submit",
              onPress: () {
                ProgressDialog pr = ProgressDialog(context,
                    type: ProgressDialogType.Normal,
                    isDismissible: false,
                    showLogs: false);

                pr.style(
                    textAlign: TextAlign.left,
                    message: '  Creating Job .... ',
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
                if (ctrlDescription.text != null &&
                    ctrlTitle.text != null &&
                    ctrlAddress.text != null &&
                    ctrlPay.text != null &&
                    ctrlSpecialize.text != null &&
                    ctrlJobPrice.text != null &&
                    ctrlJobHours.text != null &&
                    jobType != null)
                  pr.show().then((value) async {
                    //try {
                    Api()
                        .createJob(
                            ctrlDescription.text,
                            ctrlTitle.text,
                            ctrlAddress.text,
                            ctrlPay.text,
                            ctrlSpecialize.text,
                            ctrlJobPrice.text,
                            ctrlJobHours.text,
                            jobType,
                            myUser.id)
                        .then((value) {
                      pr.hide();
                      if (value)
                        Fluttertoast.showToast(
                            msg: "Job successfully created",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      else
                        Fluttertoast.showToast(
                            msg: "Unable to create job at the moment",
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
                      msg: "All field are required",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
              },
              width: Dimensions.width(60),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      )),
    );
  }
}
