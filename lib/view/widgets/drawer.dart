import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: Dimensions.height(10),
          ),
          DrawerItem(title: "Profile", onPress: () {},leading:EvaIcons.person,),
          DrawerItem(title: "Jobs", onPress: () {},leading: Icons.work,),
          DrawerItem(title: "Offers", onPress: () {},leading: EvaIcons.award,),
          DrawerItem(title: "Balance", onPress: () {},leading: Icons.monetization_on,),
          DrawerItem(title: "Account", onPress: () {},leading:Icons.settings),
          DrawerItem(title: "Logout", onPress: () {},leading: EvaIcons.logOut,),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final Function onPress;
  final IconData leading;
  const DrawerItem({
    Key key,
    @required this.title,
    @required this.onPress, this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(title),
          leading: Icon(leading,color: fontColor,),
          trailing: Icon(
            Icons.arrow_back_ios,
            textDirection: TextDirection.rtl,
            color: fontColor,
          ),
          onTap: onPress,
        ),
        Divider()
      ],
    );
  }
}
