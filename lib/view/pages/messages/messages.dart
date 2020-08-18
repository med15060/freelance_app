import 'dart:math';
import 'package:freelance_app/main.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/view/pages/messages/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freelance_app/main.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key key}) : super(key: key);

  Future<List> getChats() async {
    QuerySnapshot sentChat = await Firestore.instance
        .collection("messages")
        .where("recieverId", isEqualTo: myUser.id)
        .getDocuments();
    QuerySnapshot recievedChat = await Firestore.instance
        .collection("messages")
        .where("senderId", isEqualTo: myUser.id)
        .getDocuments();

    List<DocumentSnapshot> combinedList = [];
    combinedList.addAll(recievedChat.documents);
    combinedList.addAll(sentChat.documents);
    print(combinedList[0].data);
    return combinedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
//           leading: IconButton(icon: Icon(Icons.menu), onPressed:()=>Scaffold.of(context).openDrawer()),
          title: Text(
            "Messages",
            style: GoogleFonts.montserrat(
                    fontSize: 30, fontWeight: FontWeight.w900)
                .apply(),
          )),
      body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
          child: FutureBuilder(
              future: getChats(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (!snapshot.hasData)

                    /*return Container(child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );*/
                  return Container(
                  child: Center(child: Text("You have no messages yet")));

                else if (snapshot.hasData)
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => MessageWidget(
                        data: snapshot.data[index],
                            lastEditTime: snapshot.data[index]['time'].toString().substring(11,16),
                            message: snapshot.data[index]['last'],
                            peerUsername: myUser.id!=snapshot.data[index]['recieverId']?snapshot.data[index]['reciever']:snapshot.data[index]['sender'],
                            profileUrl: 'profile.png',
                            isRead: myUser.id==snapshot.data[index]['recieverId']?true:false,
                          ));
                else
                  return Container(
                    child: Center(
                      child: Text("Unable to get the review"),
                    ),
                  );
              })),
    );
  }
}
