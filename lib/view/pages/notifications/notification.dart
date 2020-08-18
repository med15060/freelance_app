import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/api/api.dart';
import 'package:freelance_app/models/notification.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/view/pages/notifications/widgets.dart';
import 'package:freelance_app/view/widgets/appbar.dart';
import 'package:freelance_app/view/widgets/auth_header.dart';

class NotificationPage extends StatelessWidget {
  final MyNotification data;
  static List iconList = [
    Icons.notifications_none,
    EvaIcons.doneAll,
    EvaIcons.messageSquareOutline
  ];
  static List colorList = [
    primary,
    Color.fromRGBO(46, 208, 130, 1),
    primary,
  ];
  const NotificationPage({Key key, this.data}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: Api().getNotifications(),
            builder:
                (BuildContext context, AsyncSnapshot<List<MyNotification>> snapshot) {
              print(data.toString());
              if (!snapshot.hasData)
                return Column(
                    children: <Widget>[
                      AuthHeader(
                        title: "Notifications",
                        bottomMargin: 20,
                      ), Center(child: Text("No Notifications yet"))]


                );
              else if (snapshot.hasData)
                return Scaffold(
                  appBar: CustomAppbar.appbar(
                    "Notifications",
//        leading: IconButton(
//            icon: Icon(Icons.menu),
//            onPressed: () => Scaffold.of(context).openDrawer()),
                  ),
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: ListView.builder(
                        itemCount:  snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NotificationWidget(
                            iconData: iconList[index],
                            date: 'Now',
                            username:  snapshot.data[index].username.toString(),
                            notificationContent: snapshot.data[index].notificationContent,
                            userProfile: snapshot.data[index].userProfile,
                            iconColor: colorList[index],
                          );
                        },
                      ),
                    ),
                  ),
                );
              else if (snapshot.hasData)
                return Column(

                );
              else
                return Container(
                    child: Center(child: Text("No Notifications")));
            }));
  }
}




