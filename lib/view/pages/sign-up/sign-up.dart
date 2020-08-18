import 'dart:convert';
import 'package:freelance_app/api/api.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/homePage.dart';
import 'package:freelance_app/view/pages/sign-up/widgets.dart';
import 'package:freelance_app/view/widgets/auth_header.dart';
import 'package:freelance_app/view/widgets/circular_border_button.dart';
import 'package:freelance_app/view/widgets/text_span.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as mjd;
import 'package:google_fonts/google_fonts.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:freelance_app/view/pages/login.dart';
import 'package:fluttertoast/fluttertoast.dart';


/*

̣password1
email
first_name
last_name
username
description
seller
phone
country
address
specializes
profile_picture
**/



class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isShowBuyerForm;
  String name,
      lastName,
      email,
      password,
      phone,
      hourlyRate,
      country,
      state,
      address,
      zip,
      specializes,
      description;
  TextEditingController passwordController = new TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    isShowBuyerForm = false;
  }

  void showBuyerForm() {
    if (!isShowBuyerForm) {
      setState(() {
        isShowBuyerForm = true;
      });
    }
  }

  void showSellerForm() {
    if (isShowBuyerForm) {
      setState(() {
        isShowBuyerForm = false;
      });
    }
  }

  Widget sellerSignup() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your name';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => name = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Name",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your Last name';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => lastName = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Last Name",
                  hintStyle:
                  GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your phone';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => phone = val),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Phone",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your email';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => email = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Email",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your hourly rate';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => hourlyRate = val),
              style: TextStyle(color: fontColor),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(

                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Hourly Rate",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your specialize field';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => specializes = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Specializes",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your address';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => address = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Address",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your country';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => country = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Country",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your state';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => state = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "State",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your zip';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => zip = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Zip",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                } else
                  return null;
              },
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Password",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(

              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your confirm password';
                } else if (passwordController.text != value)
                  return "Passwords didn't match";
                else
                  return null;
              },
              onSaved: (val) => setState(() => password = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Confirm Password",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              maxLines: 3,
              validator: (value) {
                if (value.isEmpty)
                  return 'Please enter your brief introduction';
                else
                  return null;
              },
              onSaved: (val) => setState(() => description = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Introduction",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ));
  }

  Widget buyerSignup() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your name';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => name = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Name",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your phone';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => phone = val),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Phone",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your email';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => email = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Email",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your address';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => address = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Address",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your country';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => country = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Country",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your state';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => state = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "State",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your zip';
                } else
                  return null;
              },
              onSaved: (val) => setState(() => zip = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Zip",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(

              obscureText: true,
              controller: passwordController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                } else
                  return null;
              },
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Password",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(

              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your confirm password';
                } else if (passwordController.text != value)
                  return "Passwords didn't match";
                else
                  return null;
              },
              onSaved: (val) => setState(() => password = val),
              style: TextStyle(color: fontColor),
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0.25,
                      )),
                  hintText: "Confirm Password",
                  hintStyle:
                      GoogleFonts.openSans(color: fontGreyColor).apply()),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Sign-up",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
//            AuthHeader(
//              title: 'Sign-up',
//              bottomMargin: Dimensions.height(4),
//            ),

                SizedBox(
                  height: 20,
                ),
                UserTypeSelector(
                  onPress1: showBuyerForm,
                  onPress2: showSellerForm,
                  isShowBuyerForm: isShowBuyerForm,
                ),
                Form(
                    key: _formKey,
                    child: isShowBuyerForm ? buyerSignup() : sellerSignup()),
                RoundedCornerButton(
                  text: 'Sign-up',
                  onPress: () {
                    print("MJD: BTN SIGN UP =>" + isShowBuyerForm.toString());
                    final FormState form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      ProgressDialog pr = ProgressDialog(context,
                          type: ProgressDialogType.Normal,
                          isDismissible: false,
                          showLogs: false);

                      pr.style(
                          textAlign: TextAlign.left,
                          message: '  Creating Account .... ',
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
                        if (isShowBuyerForm) {
                          Api()
                              .signup(
                            address: address,
                            zip: zip,
                            state: state,
                            phone: phone,
                            country: country,
                            email: email,
                            name: name,
                            lastname: lastName,
                            password: password,
                            userType: "false",
                          )
                              .then((value) {
                            pr.hide();
                            if (value != null){
                              Fluttertoast.showToast(
                                  msg: "Account successfully created",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Login()),
                              );
                            }
                            else
                              Fluttertoast.showToast(
                                  msg:
                                      "Unablet to create account at the moment",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                          });
                        } else {
                          Api()
                              .signup(
                                  address: address,
                                  zip: zip,
                                  state: state,
                                  phone: phone,
                                  country: country,
                                  email: email,
                                  name: name,
                              lastname: lastName,
                                  password: password,
                                  userType: "true",
                                  description: description,
                                  specializes: specializes,
                                  hourlyRate: hourlyRate)
                              .then((value) {
                            pr.hide();
                            if (value != null){
                              Fluttertoast.showToast(
                                  msg: "Account successfully created",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Login()),
                              );
                            }
                            else
                              Fluttertoast.showToast(
                                  msg:
                                      "Unablet to create account at the moment",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                          });
                        }
                      });
                    }
                  },
                  width: Dimensions.width(70),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomTextSpan(
                  text1: "You don't have an account ? ",
                  text2: "Log-in",
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  )
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          width: MediaQuery.of(context).size.width,
        ));
  }
}
