import 'dart:convert';
import 'package:freelance_app/main.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/models/sellers.dart';
//import 'package:freelance_app/models/user.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/profile/widgets.dart';
import 'package:freelance_app/view/widgets/back_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as mjd;

class Profile extends StatefulWidget {
  Profile({Key key, this.title, this.user}) : super(key: key);
  final String title;
  final Seller user ;
  @override
  ProfileState createState() => ProfileState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: user.name==null?"user name":user.name,
      theme: ThemeData(
          //fontFamily: "GESSTwoMedium",
          backgroundColor: Colors.transparent),
      home: Profile(title:user.name==null?"user name":user.name),
    );
  }
}

class ProfileState extends State<Profile> {
  static final specializations = ["Home Visit", "Repairs"];
  String User_name = "";
  String User_distance = "0";
  String User_job_number = "0";
  String User_profile = "";
  String User_stars = "";

  @override
  void initState() {
    // TODO: implement initState
//    print("MJD: INIT STATE PPROFILE");
//    String url = "http://192.168.1.101:8000/api/user/1/";
//    print(url.toString());
//
//    ProgressDialog pr = ProgressDialog(context,
//        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
//
//    pr.style(
//        textAlign: TextAlign.right,
//        message: '  ... جاري الـتحـقق',
//        borderRadius: 0.5,
//        backgroundColor: Colors.white,
//        progressWidget: CircularProgressIndicator(
//          strokeWidth: 3,
//          backgroundColor: Colors.white,
//        ),
//        elevation: 1.0,
//        insetAnimCurve: Curves.easeInOut,
//        progress: 5.0,
//        maxProgress: 100.0,
//        progressTextStyle: TextStyle(
//            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w200),
//        messageTextStyle: TextStyle(
//            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w600));
//
//    pr.show().then((value) async {
//      //try {
//      mjd.Response res = await mjd.get(url);
//      if (res.statusCode == 200) {
//        print("INTERNET OK");
//        Map<String, dynamic> data = jsonDecode(res.body);
//        print(data.toString());
//        setState(() {
//          User_name = data['name'];
//          User_distance = data['distance_in_miles'];
//          User_job_number = data['how_many_jobs'];
//          User_profile = data['profile_picture'];
//          User_stars = data['stars_value'];
//          print("MJD: STARS =>"+User_stars);
//        });
//        pr.hide();
//      }
//    });
  /*shouldShowFooter ? new Footer() : null**/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
            widget.user.name==null?"user name":widget.user.name,//  'Back',
        ),
        leading: CustomBackButton(),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Image.asset(
              widget.user.profile==null?"":widget.user.profile,
              width: 25,
              height: 25,
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage(
                          widget.user.profile==null?"":widget.user.profile
                      ),
                      radius: 35,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      myUser.name,
                      style: GoogleFonts.montserrat(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: fontColor)
                          .apply(),
                    )
                  ],
                ),
                Headline(text: 'Information'),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    UserInfoWidget(
                      icon: Icons.work,
                      text:  widget.user.how_many_jobs==null?"user name":widget.user.how_many_jobs  + ' jobs',
                    ),
                    UserInfoWidget(
                      icon: Icons.star,
                      text:  widget.user.rate==null? "0" : widget.user.rate.toString(),
                    ),
                    UserInfoWidget(
                      icon: Icons.location_on,
                      text:  widget.user.distance_in_miles + ' miles away',
                    )
                  ],
                ),
                Headline(text: "Description"),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.user.description, style: GoogleFonts.openSans(fontSize: 16).apply(),
                ),
                Headline(text: "Specializes"),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: Dimensions.height(5),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 1,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (contex, index) => Specialize(
                      text:  widget.user.specializes==null?"IT":myUser.specializes,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Last Reviews',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "View all",
                        style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primary)
                            .apply(),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: Dimensions.height(12),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 2,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (contex, index) => Reviews(
                      reviewValue: 4.5,
                      reviewText: "Quickly and easily solved every problem.",
                    ),
                  ),
                ),
                Headline(text: "Jobs"),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    shrinkWrap: true,
                    itemBuilder: (cxt, index) => SizedBox(
                          height: Dimensions.height(12),
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 2,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (contex, i) => JobWidget(
                                  rating: 5, jobTitle: "Fixing network error")),
                        ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
