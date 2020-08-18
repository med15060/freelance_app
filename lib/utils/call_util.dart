import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freelance_app/models/call.dart';
import 'package:freelance_app/models/user.dart';
import 'package:freelance_app/resources/call_methods.dart';
import 'package:freelance_app/view/pages/chat/call.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({User from, User to, context}) async {
    Call call = Call(
      callerId: from.id.toString(),
      callerName: from.name,
      callerPic: "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
      receiverId: to.id.toString(),
      receiverName: to.name,
      receiverPic: "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
          ));
    }
  }
}