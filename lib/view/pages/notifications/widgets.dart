import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/view/widgets/text_span.dart';

class NotificationWidget extends StatelessWidget {
  final String userProfile;
  final String username;
  final String notificationContent;
  final String date;
  final IconData iconData;
  final Color iconColor;
  const NotificationWidget(
      {Key key,
      this.userProfile,
      this.notificationContent,
      this.date,
      this.iconData,
      this.iconColor,
      this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Stack(children: [
           if (userProfile==null) CircleAvatar(
              backgroundImage:NetworkImage(userProfile),
              radius: 35,
            ) else null,
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration:
                      BoxDecoration(color: iconColor, shape: BoxShape.circle),
                  child: Icon(
                    iconData,
                    size: 20,
                    color: Colors.white,
                  )),
            )
          ]),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: username==null?"":username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: fontColor,
                        fontSize: 16),
                  ),
                  TextSpan(
                    text: notificationContent,
                  )
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Text(date==null?"":date)
            ],
          )
        ],
      ),
    );
  }
}
