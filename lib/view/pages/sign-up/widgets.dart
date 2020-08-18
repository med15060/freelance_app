import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/widgets/text_field.dart';

class UserTypeSelector extends StatelessWidget {
  final Function onPress1;
  final Function onPress2;
  final bool isShowBuyerForm;
  const UserTypeSelector({
    Key key,
    @required this.onPress1,
    @required this.onPress2,
    @required this.isShowBuyerForm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      width: Dimensions.width(70),
      height: Dimensions.height(5),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: onPress1,
            child: Container(
              height: Dimensions.height(5),
              width: Dimensions.width(35),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(30),
                  ),
                  border: Border.all(color: borderColor),
                  color: isShowBuyerForm ? primary : background),
              child: Center(
                  child: Text(
                'Buyer',
                style: TextStyle(
                    color: isShowBuyerForm ? Colors.white : primary,
                    fontSize: 17),
              )),
            ),
          ),
          InkWell(
            onTap: onPress2,
            child: Container(
              width: Dimensions.width(35),
              height: Dimensions.height(5),
              child: Center(
                child: Text(
                  'Seller',
                  style: TextStyle(
                      color: isShowBuyerForm ? primary : Colors.white,
                      fontSize: 17),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(30),
                  ),
                  color: !isShowBuyerForm ? primary : background,
                  border: Border.all(color: borderColor)),
            ),
          ),
        ],
      ),
    );
  }
}

class BuyerForm extends StatelessWidget {
  const BuyerForm({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Animator(
      curve: Curves.easeInOutCubic,
      duration: Duration(milliseconds: 400),
      triggerOnInit: true,
      // resetAnimationOnRebuild: true,
      tween: Tween<double>(begin: -450, end: 0),
      builder: (context, anim, child) => Transform.translate(
        offset: Offset(anim.value, 0),
        child: Column(
          children: <Widget>[
            _RegisterForm(),
            CustomTextField(
                hint: '',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Upload CV',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      Icons.file_upload,
                      color: Colors.grey,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class SellerForm extends StatelessWidget {
  TextEditingController CtrlEmail = new TextEditingController();
  TextEditingController CtrlPhone = new TextEditingController();
  TextEditingController CtrlPassword = new TextEditingController();
  TextEditingController CtrlRePassword = new TextEditingController();
  TextEditingController CtrlAddress = new TextEditingController();
  SellerForm(
      {Key key,
      this.CtrlEmail,
      this.CtrlAddress,
      this.CtrlRePassword,
      this.CtrlPassword,
      this.CtrlPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Animator(
      curve: Curves.easeInOutCubic,
      duration: Duration(milliseconds: 400),
      triggerOnInit: true,
      // resetAnimationOnRebuild: true,
      tween: Tween<double>(begin: 450, end: 0),
      builder: (context, anim, child) => Transform.translate(
        offset: Offset(anim.value, 0),
        child: _RegisterForm(
            CtrlEmail: this.CtrlEmail,
            CtrlAddress: this.CtrlAddress,
            CtrlPhone: this.CtrlPhone,
            CtrlPassword: this.CtrlPassword,
            CtrlRePassword: this.CtrlRePassword),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  TextEditingController CtrlEmail = new TextEditingController();
  TextEditingController CtrlPhone = new TextEditingController();
  TextEditingController CtrlPassword = new TextEditingController();
  TextEditingController CtrlRePassword = new TextEditingController();
  TextEditingController CtrlAddress = new TextEditingController();

  _RegisterForm(
      {Key key,
      this.CtrlEmail,
      this.CtrlPhone,
      this.CtrlPassword,
      this.CtrlRePassword,
      this.CtrlAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomTextField(hint: "Email", textEditingController: CtrlEmail),
        CustomTextField(hint: "Phone Number", textEditingController: CtrlPhone),
        CustomTextField(hint: "Password", textEditingController: CtrlPassword),
        CustomTextField(
            hint: "Confirm Password", textEditingController: CtrlRePassword),
        CustomTextField(hint: "Address", textEditingController: CtrlAddress),
      ],
    );
  }
}
