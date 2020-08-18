import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelance_app/api/api.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/create_job/widget.dart';
import 'package:freelance_app/view/widgets/auth_header.dart';
import 'package:freelance_app/view/widgets/circular_border_button.dart';
import 'package:freelance_app/view/widgets/text_field.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AskForHelp extends StatelessWidget {
  const AskForHelp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var textEditingCtrlMessage;
    TextEditingController textEditingCtrlMessage = new TextEditingController();
    return Scaffold(
      body: Column(
        children: <Widget>[
          AuthHeader(title: "Ask For Help"),
          CustomTextField(
            textEditingController: textEditingCtrlMessage,
            height: Dimensions.height(30),
            hint: "Description",
            expandes: true,
          ),
          CustomTextField(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Upload File',
                    style: TextStyle(
                      color: fontGreyColor,
                    ),
                  ),
                  Icon(
                    Icons.file_upload,
                    color: fontGreyColor,
                  )
                ],
              ),
            ),
/*            Container(
              //margin: const EdgeInsets.only(top: 20),
              width: Dimensions.width(80),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return UploadedFileWidget(
                    filename: 'Iphone_image.png',
                  );
                },
              ),
            ),*/
            RoundedCornerButton(text: "Submit", onPress: (){
              ProgressDialog pr = ProgressDialog(context,
                  type: ProgressDialogType.Normal,
                  isDismissible: false,
                  showLogs: false);
              if (textEditingCtrlMessage.text != null)
                pr.show().then((value) async {
                  Api()
                      .Hellperequest(

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



             // Api().Hellperequest()
            }, width: Dimensions.width(80))
        ],
      ),
    );
  }
}



