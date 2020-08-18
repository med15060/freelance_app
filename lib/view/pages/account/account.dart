import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/ask_for_help/ask_for_help.dart';
import 'package:freelance_app/view/pages/profile/widgets.dart';
import 'package:freelance_app/view/pages/withDraw/with_draw.dart';
import 'package:freelance_app/view/widgets/appbar.dart';
import 'package:freelance_app/view/widgets/back_button.dart';
import 'package:freelance_app/view/widgets/text_field.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as mjd;
import 'package:freelance_app/main.dart';
import 'package:freelance_app/view/pages/login.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<AccountPage> {
  String name = "";
  String email = "";
  String country = "";
  String state = "";
  String address = "";
  String zip = "";
  String phone = "";
  String type = "";
  String password = "";
  TextEditingController textEditingCtrlPhone = new TextEditingController();
  TextEditingController textEditingCtrlEmail = new TextEditingController();
  TextEditingController textEditingCtrlCountry = new TextEditingController();
  TextEditingController textEditingCtrlState = new TextEditingController();
  TextEditingController textEditingCtrlAddress = new TextEditingController();
  TextEditingController textEditingCtrlType = new TextEditingController();
  TextEditingController textEditingCtrlZip = new TextEditingController();
  TextEditingController textEditingCtrlName = new TextEditingController();
  TextEditingController textEditingCtrlPassword = new TextEditingController();
  TextEditingController textEditingCtrlSpecialise = new TextEditingController();

  void initState() {
    textEditingCtrlPhone.text = myUser.phone;
    textEditingCtrlEmail.text = myUser.email;
    textEditingCtrlCountry.text = myUser.country;
    textEditingCtrlState.text = myUser.state;
    textEditingCtrlAddress.text = myUser.address;
    textEditingCtrlType.text = myUser.usertype;
    textEditingCtrlZip.text = myUser.zip;
    textEditingCtrlName.text = myUser.name;
    textEditingCtrlSpecialise.text = myUser.specializes;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appbar('Account', centerTitle: false, actions: [
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          ),
        ), IconButton(
          icon: Icon(Icons.help_outline ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AskForHelp()),
          ),
        ),IconButton(
            icon: Icon(Icons.account_balance_wallet  ),
            onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WithDrawPage()),
            ),
    )
      ]
//        leading: IconButton(
//            icon: Icon(Icons.menu),
//            onPressed: () => Scaffold.of(context).openDrawer()),
          ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Headline(text: "Information"),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                textEditingController: textEditingCtrlName,
                label: "Name",
                width: Dimensions.width(90),
                margin: const EdgeInsets.only(bottom: 20),
              ),
              CustomTextField(
                textEditingController: textEditingCtrlPhone,
                label: "Phone Number",
                width: Dimensions.width(90),
                margin: const EdgeInsets.only(bottom: 20),
              ),
              CustomTextField(
                textEditingController: textEditingCtrlEmail,
                label: "Email Address",
                width: Dimensions.width(90),
                margin: const EdgeInsets.only(bottom: 20),
              ),
              CustomTextField(
                textEditingController: textEditingCtrlPassword,
                label: "Password",
                width: Dimensions.width(90),
                margin: const EdgeInsets.only(bottom: 20),
              ),
              CustomTextField(
                textEditingController: textEditingCtrlCountry,
                label: "Country",
                width: Dimensions.width(90),
                margin: const EdgeInsets.only(bottom: 20),
              ),
              CustomTextField(
                textEditingController: textEditingCtrlState,
                label: "State",
                width: Dimensions.width(90),
                margin: const EdgeInsets.only(bottom: 20),
              ),
              CustomTextField(
                textEditingController: textEditingCtrlAddress,
                label: "Address",
                width: Dimensions.width(90),
                margin: const EdgeInsets.only(bottom: 20),
              ),
              CustomTextField(
                textEditingController: textEditingCtrlZip,
                label: "Zip Code",
                width: Dimensions.width(90),
                margin: const EdgeInsets.only(bottom: 20),
              ),
              myUser.usertype != "true"
                  ? Container()
                  : Headline(text: "Selling"),

              myUser.usertype != "true"
                  ? Container()
                  : SizedBox(
                      height: 10,
                    ),

              myUser.usertype != "true"
                  ? Container()
                  : CustomTextField(
                      textEditingController: textEditingCtrlSpecialise,
                      label: "Specialise",
                      width: Dimensions.width(90),
                      margin: const EdgeInsets.only(bottom: 20),
                    ),
//              Headline(text: "General"),
//              SizedBox(
//                height: 10,
//              ),
//              CustomTextField(
//                label: "Type",
//                width: Dimensions.width(90),
//                margin: const EdgeInsets.only(bottom: 20),
//              ),
//              CustomTextField(
//                label: "Type",
//                width: Dimensions.width(90),
//                margin: const EdgeInsets.only(bottom: 20),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}
