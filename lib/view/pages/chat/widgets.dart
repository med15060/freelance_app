import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatActions extends StatelessWidget {
  final String image,name;
  const ChatActions({Key key,@required this.image,@required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
      Container(
                  child: ClipRRect(
                    child: CachedNetworkImage(
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/images/profile.png",
                          fit: BoxFit.fill,
                        ),
                        placeholder: (context, url) => Image.asset(
                          "assets/images/placeholder.png",
                          fit: BoxFit.fill,
                        ),
                        fit: BoxFit.fill,
                        imageUrl: image),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  height: 40,
                  width: 40,
                ),
          SizedBox(
            width: 10,
          ),
          Text(
            name,
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Expanded(child: SizedBox()),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.call),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.videocam),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SentMessage extends StatelessWidget {
  final String message;
  const SentMessage({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(10),
        width: message.length > 39
                                ? Dimensions.width(60)
                                : null,
        margin: EdgeInsets.only(bottom: 10),
        constraints: BoxConstraints(minHeight: Dimensions.height(8)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
          color: Color.fromRGBO(124, 133, 255, 1),
        ),
        child: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}

class ReceivedMessage extends StatelessWidget {
  final String message;
  const ReceivedMessage({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        width: message.length > 39
            ? Dimensions.width(60)
            : null,
        margin: EdgeInsets.only(bottom: 10),
        constraints: BoxConstraints(minHeight: Dimensions.height(8)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          color: Color.fromRGBO(165, 165, 165, 1),
        ),
        child: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}

class SendMessageWidget extends StatelessWidget {
  const SendMessageWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 20,left: 10,right: 10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
    BoxShadow(
        color: Colors.grey[200], offset: Offset(3, -3), blurRadius: 12)
        ]),
        child: Row(
    children: <Widget>[
     ShareMedia(
        icon: Icons.camera_alt,
        onPress: (){},
      ),
     ShareMedia(
        icon: Icons.mic,
        onPress: (){},
      ),
      ShareMedia(
        icon: Icons.attach_file,
        onPress: (){},
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Type a message ..."
        ),
      )),
      FlatButton(
          onPressed: () {},
          child: Text(
            'SEND',
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.bold,
            ),
          ))
    ],
        ),
      );
  }
}

class ShareMedia extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  const ShareMedia({
    Key key,
    @required this.icon,
    @required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPress,
      ),
    );
  }
}

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final bool isRound;
  final double radius;
  final double height;
  final double width;

  final BoxFit fit;

  final String noImageAvailable =
      "https://www.esm.rochester.edu/uploads/NoPhotoAvailable.jpg";

  CachedImage(
      this.imageUrl, {
        this.isRound = false,
        this.radius = 0,
        this.height,
        this.width,
        this.fit = BoxFit.cover,
      });

  @override
  Widget build(BuildContext context) {
    try {
      return SizedBox(
        height: isRound ? radius : height,
        width: isRound ? radius : width,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(isRound ? 50 : radius),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: fit,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  Image.network(noImageAvailable, fit: BoxFit.cover),
            )),
      );
    } catch (e) {
      print(e);
      return Image.network(noImageAvailable, fit: BoxFit.cover);
    }
  }
}