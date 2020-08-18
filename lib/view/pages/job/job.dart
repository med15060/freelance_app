//import 'dart:convert';
//import 'package:freelance_app/api/api.dart';
//import 'package:carousel_pro/carousel_pro.dart';
//import 'package:flutter/material.dart';
//import 'package:freelance_app/utils/screen_dimensions_helper.dart';
//import 'package:freelance_app/view/widgets/appbar.dart';
//import 'package:freelance_app/view/widgets/back_button.dart';
//import 'package:freelance_app/view/widgets/carousel.dart';
//import 'package:freelance_app/view/widgets/circular_border_button.dart';
//import 'package:freelance_app/view/widgets/text_field.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:progress_dialog/progress_dialog.dart';
//import 'package:http/http.dart' as mjd;
//import 'package:freelance_app/main.dart';
//import 'package:freelance_app/models/job.dart';
//
//class JobPage extends StatefulWidget {
//  JobPage({
//    Key key,
//  }) : super(key: key);
//
//  @override
//  JobState createState() => JobState();
//}
//
//class JobState extends State<JobPage> {
//  String Description = '';
//  String Address = '';
//  String Pay = '';
//  String Image = '';
//
//  @override
//  void initState() {
//    // TODO: implement initState
////    print("MJD: INIT STATE PPROFILE");
////    String url = "http://192.168.1.101:8000/api/job/1/";
////    print(url.toString());
////
////    ProgressDialog pr = ProgressDialog(context,
////        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
////
////    pr.style(
////        textAlign: TextAlign.right,
////        message: '  ... جاري الـتحـقق',
////        borderRadius: 0.5,
////        backgroundColor: Colors.white,
////        progressWidget: CircularProgressIndicator(
////          strokeWidth: 3,
////          backgroundColor: Colors.white,
////        ),
////        elevation: 1.0,
////        insetAnimCurve: Curves.easeInOut,
////        progress: 5.0,
////        maxProgress: 100.0,
////        progressTextStyle: TextStyle(
////            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w200),
////        messageTextStyle: TextStyle(
////            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w600));
////
////    pr.show().then((value) async {
////      //try {
////      mjd.Response res = await mjd.get(url);
////      if (res.statusCode == 200) {
////        print("INTERNET OK");
////        Map<String, dynamic> data = jsonDecode(res.body);
////        print("MJD:DATA");
////        print(data.toString());
////        setState(() {
////          Description = data['description'];
////          Address = data['address'];
////          Pay = data['pay'];
////          Image = data['image'];
////        });
////        pr.hide();
////      }
////    });
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: CustomAppbar.appbar(
//        "",
//        leading: IconButton(
//            icon: Icon(Icons.menu),
//            onPressed: () => Scaffold.of(context).openDrawer()),
//        // leading: CustomBackButton(),
//      ),
//      body: FutureBuilder(
//          future: Api().getJob(myUser.job.toString()),
//          builder: (BuildContext context, AsyncSnapshot<Job> snapshot) {
//            if (!snapshot.hasData)
//              return Container(
//                child: Center(
//                  child: CircularProgressIndicator(
//                    strokeWidth: 3,
//                  ),
//                ),
//              );
//            else if (snapshot.hasData)
//              return Center(
//                child: SingleChildScrollView(
//                  child: Column(
//                    children: <Widget>[
//                      CircleAvatar(
//                        radius: 45,
//                        backgroundImage: AssetImage(
//                          'assets/images/profile.png',
//                        ),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Text(
//                        snapshot.data.title,
//                        style: GoogleFonts.montserrat(
//                            fontWeight: FontWeight.bold, fontSize: 20),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.only(top: 20),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Container(
//                              width: 100,
////                      height: 30,
//                              padding: EdgeInsets.all(10),
//                              decoration: BoxDecoration(
//                                  color: Colors.white,
//                                  borderRadius: BorderRadius.circular(5),
//                                  border: Border.all(
//                                      color: Colors.grey, width: 0.25)),
//                              child: Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceEvenly,
//                                children: <Widget>[
//                                  Icon(Icons.monetization_on),
//                                  Text(
//                                    snapshot.data.job_price,
//                                  )
//                                ],
//                              ),
//                            ),
////                    CustomTextField(
////                      width: Dimensions.width(36),
////                      suffix:  Icon(Icons.monetization_on),
////                      hint: myUser.hourly_rate,
////                    ),
//                            SizedBox(
//                              width: Dimensions.width(4),
//                            ),
//                            Container(
//                              width: 100,
////                      height: 30,
//                              padding: EdgeInsets.all(10),
//                              decoration: BoxDecoration(
//                                  color: Colors.white,
//                                  borderRadius: BorderRadius.circular(5),
//                                  border: Border.all(
//                                      color: Colors.grey, width: 0.25)),
//                              child: Row(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceEvenly,
//                                children: <Widget>[
//                                  Icon(Icons.timer),
//                                  Text(
//                                    snapshot.data.job_hours,
//                                  )
//                                ],
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      Container(
//                        width: MediaQuery.of(context).size.width * 0.8,
////                      height: 30,
//                        padding: EdgeInsets.all(10),
//                        decoration: BoxDecoration(
//                            color: Colors.white,
//                            borderRadius: BorderRadius.circular(5),
//                            border:
//                                Border.all(color: Colors.grey, width: 0.25)),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          children: <Widget>[
//                            Flexible(
//                                child: RichText(
//                              text: TextSpan(children: <TextSpan>[
//                                TextSpan(
//                                  text: "Description: ",
//                                  style: TextStyle(
//                                      fontWeight: FontWeight.bold,
//                                      color: Colors.black),
//                                ),
//                                TextSpan(
//                                    text: snapshot.data.description,
//                                    style: TextStyle(color: Colors.black)),
//                              ]),
////
//                            ))
//                          ],
//                        ),
//                      ),
//                      SizedBox(
//                        height: 10,
//                      ),
//                      CustomCarousel(
//                        images: ["assets/images/fix.jpg"],
//                      ),
//                      SizedBox(
//                        height: Dimensions.height(6),
//                      ),
//
////              SizedBox(height: 100)
//                    ],
//                  ),
//                ),
//              );
//            else
//              return Container(child: Center(child: Text("No active job")));
//          }),
//      bottomNavigationBar: Container(
//        height: 20,
//        child: Row(
//          children: <Widget>[
////          InkWell(child: ,)
//          ],
//        ),
//      ),
//    );
//  }
//}

import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/job/widgets.dart';
import 'package:freelance_app/view/widgets/back_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:freelance_app/main.dart';
import 'package:freelance_app/api/api.dart';
import 'package:freelance_app/models/review.dart';
import 'package:freelance_app/models/job.dart';

class JobPage extends StatelessWidget {
  const JobPage({Key key}) : super(key: key);
  static final specializations = ["Home Visit", "Repairs"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
//        title: Text(
//          'Back',
//        ),
//        leading: CustomBackButton(),
        actions: <Widget>[
//          Padding(
//            padding: const EdgeInsets.symmetric(
//              horizontal: 20,
//            ),
//            child: Image.asset(
//              'assets/images/edit.png',
//              width: 25,
//              height: 25,
//            ),
//          )
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
                        'assets/images/profile.png',
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
                      text: myUser.how_many_jobs + ' jobs',
                    ),
                    UserInfoWidget(
                      icon: Icons.star,
                      text: myUser.stars_value,
                    ),
                    UserInfoWidget(
                      icon: Icons.location_on,
                      text: myUser.distance_in_miles + ' miles away',
                    )
                  ],
                ),
                Headline(text: "Description"),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  myUser.description,
                  style: GoogleFonts.openSans(fontSize: 16).apply(),
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
                      text: myUser.specializes,
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
//                    Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 20),
//                      child: Text(
//                        "View all",
//                        style: GoogleFonts.openSans(
//                                fontSize: 16,
//                                fontWeight: FontWeight.w600,
//                                color: primary)
//                            .apply(),
//                      ),
//                    ),
                  ],
                ),
                FutureBuilder(
                    future: Api().getUserReviews(myUser.id),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Review>> snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      else if (snapshot.hasData) if (snapshot.data.isEmpty)
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text("No review at the moment"),
                          ),
                        );
                      else
                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: Dimensions.height(12),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: snapshot.data.length,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Reviews(
                              reviewValue: double.tryParse(
                                  "${snapshot.data[index].stars}"),
                              reviewText: snapshot.data[index].review,
                            ),
                          ),
                        );
                      else
                        return Container(
                          child: Center(
                            child: Text("Unable to get the review"),
                          ),
                        );
                    }),
                Headline(text: "Jobs"),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: Api().getMyJobs(myUser.id),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Job>> snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      else if (snapshot.hasData) if (snapshot.data.isEmpty)
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text("No job at the moment"),
                          ),
                        );
                      else
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) => JobWidget(
                                description: snapshot.data[index].description,
                                jobTitle: snapshot.data[index].title)
//                            itemBuilder: (cxt, index) => SizedBox(
//                                  height: Dimensions.height(12),
//                                  child: ListView.builder(
//                                      physics: BouncingScrollPhysics(),
//                                      shrinkWrap: true,
//                                      itemCount: 2,
//                                      scrollDirection: Axis.horizontal,
//                                      itemBuilder: (context, index) => JobWidget(
//                                          rating: 5,
//                                          jobTitle: "Fixing network error")),
                                );
                      else
                        return Container(
                          child: Center(
                            child: Text("Unable to get the jobs"),
                          ),
                        );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
