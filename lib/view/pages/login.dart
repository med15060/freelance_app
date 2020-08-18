import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freelance_app/main.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/homePage.dart';
import 'package:freelance_app/view/pages/sign-up/sign-up.dart';
import 'package:freelance_app/view/widgets/auth_header.dart';
import 'package:freelance_app/view/widgets/circular_border_button.dart';
import 'package:freelance_app/view/widgets/text_field.dart';
import 'package:freelance_app/view/widgets/text_span.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freelance_app/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: 'Loginn',
     theme: ThemeData(
         fontFamily: "GESSTwoMedium",
         backgroundColor: Color(242020)),
      home: Login(),
    );
  }
}

class LoginState extends State<Login> {
  TextEditingController EmailCtrl = TextEditingController();
  TextEditingController PasswordCtrl = TextEditingController();
  bool _isSellerFlag = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Login",
          style: Theme.of(context).textTheme.headline1,

        ),
      ),
      body: Center(
        child: ListView(
//          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            CustomTextField(
              hint: "Email",
              textEditingController: EmailCtrl,
            ),
            CustomTextField(
              obscure: true,
              hint: "Password",
              textEditingController: PasswordCtrl,
            ),
            Padding(
                    padding: EdgeInsets.fromLTRB(35, 0, 0, 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _isSellerFlag,
                          onChanged: (val) {
                            setState(() {
                              _isSellerFlag = val;
                            });
                          },
                        ),
                        Text("Is Seller?")
                      ],
                    )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedCornerButton(
                    text: "Log-in",
                    width: Dimensions.width(70),
                    /*onPress: () async {
                checkLogin(context, EmailCtrl.text, PasswordCtrl.text);
                //Navigator.pushReplacementNamed(context, 'home');
              },*/
                    onPress: () {
                      ProgressDialog pr = ProgressDialog(context,
                          type: ProgressDialogType.Normal,
                          isDismissible: false,
                          showLogs: false);

                      pr.style(
                          textAlign: TextAlign.left,
                          message: 'Checking ...',
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

                      pr.show().then((value) async {
                        Api()
                            .login(EmailCtrl.text.toString(),
                                PasswordCtrl.text.toString())
                            .then((response) async {
                          pr.hide();
                          //print(_isSellerFlag);

                          if (response != null) {
                            //MJD CHECK LOGIN SUCCESS _read() async {
                            //        final prefs = await SharedPreferences.getInstance();
                            //        final key = 'my_int_key';
                            //        final value = prefs.getInt(key) ?? 0;
                            //        print('read: $value');
                            //      }
                            //
                            final prefs = await SharedPreferences.getInstance();
                            myUser.usertype= _isSellerFlag.toString();
                            prefs.setString("Usertype", _isSellerFlag.toString());
                            print( _isSellerFlag.toString()+"   hiiii");

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(isSeller: _isSellerFlag)));
                          }
                          else
                            Fluttertoast.showToast(
                                msg: "Invalid email/password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                        });
                      });
                    })
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              CustomTextSpan(
                  text1: "Don't have an account ?",
                  text2: " Sign-up",
                  onTap: () {
                    print("MJD: GO TO Logout PAGE");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  })
            ])
          ],
        ),
      ),
    );
  }
}
