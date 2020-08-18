import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/screen_dimensions_helper.dart';
import '../../widgets/auth_header.dart';
import 'package:freelance_app/models/job.dart';
import 'package:freelance_app/api/api.dart';
import 'package:freelance_app/models/offers.dart';
import 'package:freelance_app/view/pages/job/widgets.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:freelance_app/view/pages/Progress/progress.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/main.dart';
import 'package:freelance_app/view/pages/chat/chat.dart';

class MyOffersPage extends StatelessWidget {
  final int id;
  const MyOffersPage({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Offers",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        body: FutureBuilder(
            future:(myUser.usertype=="true")?  Api().getMyOffers(id): Api().getAllOffers(id)  ,
            builder:
                (BuildContext context, AsyncSnapshot<List<Offer>> snapshot) {
              if (!snapshot.hasData)
                /*return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                );*/
                return Container(
                    child: Center(child: Text("No active offers Yet")));

              else if (snapshot.hasData)
                return Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: SizedBox(
                        width: Dimensions.width(90),
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => OfferItem(
                            data: snapshot.data[index],
                             //jobData: data,
                            body: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: 100,
//                      height: 30,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 0.25)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Icons.monetization_on),
                                      Text(
                                        snapshot.data[index].offer_amount
                                            .toString(),
                                      )
                                    ],
                                  ),
                                ),
//                    CustomTextField(
//                      width: Dimensions.width(36),
//                      suffix:  Icon(Icons.monetization_on),
//                      hint: myUser.hourly_rate,
//                    ),
                                SizedBox(
                                  width: Dimensions.width(4),
                                ),
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(top: 10),
//                      height: 30,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 0.25)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(Icons.timer),
                                      Text(
                                        snapshot.data[index].offer_time
                                            .toString(),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          shrinkWrap: true,
                        ),
                      ))
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                );
              else
                return Container(
                    child: Center(child: Text("No active offers")));
            }));
  }
}

class OfferItem extends StatelessWidget {
  OfferItem({Key key, this.body, this.data, this.jobData}) : super(key: key);
  final Widget body;
  final Offer data;
  final Job jobData;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[200], offset: Offset(3, 3), blurRadius: 12)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
                color: Color.fromRGBO(239, 237, 240, 1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  child: Icon(Icons.local_offer),
                  radius: 20,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  data.user_name==null ? "seller" :  data.user_name,
                  style: GoogleFonts.montserrat(
                      color: fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),

                ),

              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(8))),
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    UserInfoWidget(
                      icon: Icons.location_on,
                      text: "1.7 m",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: UserInfoWidget(
                        icon: Icons.videocam,
                        text: "Remote",
                      ),
                    ),
                    SmoothStarRating(
                      rating: double.tryParse(data.stars_value),
                      allowHalfRating: true,
                      starCount: 5,
                      size: 20,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Message",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: fontColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  data.message==null? " ":data.message,
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: body != null
                          ? Dimensions.width(55)
                          : Dimensions.width(80),
                      margin: const EdgeInsets.only(top: 20),
                      height: Dimensions.height(4),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Specialize(
                            text: data.specialize==null? " " :data.specialize,
                            color: background,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                body ?? Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
