import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance_app/main.dart';
import 'package:freelance_app/view/pages/chat/chat.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  final String peerUsername;
  final String profileUrl;
  final String lastEditTime;
  final bool isRead;
  final DocumentSnapshot data;

  const MessageWidget({
    Key key,
    @required this.message,
    @required this.peerUsername,
    @required this.profileUrl,
    @required this.lastEditTime,
    @required this.isRead,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChatScreen(
                senderId: myUser.id,
                recieverName:myUser.id== data.data['recieverId']?data.data['sender']:data.data['reciever'],
                recieverId:myUser.id== data.data['senderId']?data.data['recieverId']:data.data['senderId'],
                senderName: myUser.name,
                image:
                "https://keenthemes.com/preview/metronic/theme/assets/pages/media/profile/profile_user.jpg",
              ))),
      child: Container(
        color: !isRead ? background : Color.fromRGBO(250, 249, 254, 1),
        height: Dimensions.height(10),
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/$profileUrl'),
              radius: 25,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          peerUsername,
                          style: GoogleFonts.montserrat(
                                  color: isRead ? fontGreyColor : fontColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)
                              .apply(),
                        ),
                        SizedBox(
                            width: Dimensions.width(40),
                            child: Text(
                              message,
                              style: GoogleFonts.openSans(
                                fontSize: 13,
                              ).apply(),
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Column(
                      children: <Widget>[
                        Text(
                          lastEditTime,
                          style: GoogleFonts.openSans(fontSize: 13).apply(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (isRead)
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                                color: primary, shape: BoxShape.circle),
                          )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
