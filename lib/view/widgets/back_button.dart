import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Function onPress;
  const CustomBackButton({Key key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      disabledColor: Colors.black,
      icon: Icon(Icons.arrow_back),
      onPressed:onPress!=null?()=> onPress():()=>Navigator.pop(context),
    );
  }
}
