import 'package:flutter/material.dart';
import 'package:freelance_app/view/pages/job/widgets.dart';
import 'package:freelance_app/view/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';

import '../../../utils/screen_dimensions_helper.dart';
import 'package:freelance_app/models/job.dart';
import '';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 20),
      // width: Dimensions.width(90),
      height: Dimensions.height(6),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: borderColor,
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 12.5),
                color: Color.fromRGBO(0, 0, 0, 0.01),
                blurRadius: 10),
            BoxShadow(
                offset: Offset(0, 22.3),
                color: Color.fromRGBO(0, 0, 0, 0.0119221),
                blurRadius: 17.86),
            BoxShadow(
                offset: Offset(0, 100),
                color: Color.fromRGBO(0, 0, 0, 0.02),
                blurRadius: 80),
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          Icon(Icons.search)
        ],
      ),
    );
  }
}

class UserSearch extends StatelessWidget {
   UserSearch({Key key, this.body,this.data,this.offers=false}) : super(key: key);
  final Widget body;
  final Job data;
  bool offers;
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
               /* CircleAvatar(
                  backgroundImage:AssetImage('assets/images/profile.png'),//Image.network(data.profile_url), //AssetImage('assets/images/profile.png'),
                  radius: 20,
                ),**/
                SizedBox(
                  width: 30,
                ),
                Text(
                 data.title,
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
                      rating: 4.5,
                      allowHalfRating: true,
                      starCount: 5,
                      size: 20,
                      isReadOnly: true,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Description",
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: fontColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  data.description,
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
                            text: data.specialize,
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

class AppBarBottom extends StatelessWidget {
  const AppBarBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          CustomTextField(
            hint: "",
            margin: EdgeInsets.only(top: 30),
            height: Dimensions.height(6),
            width: Dimensions.width(100),
            suffix: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.search),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.filter_list,
                size: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Filters',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Expanded(child: SizedBox()),
//              Container(
//                padding: const EdgeInsets.symmetric(horizontal: 10),
//                decoration: BoxDecoration(
//                    border: Border.all(color: borderColor),
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(10)
//                ),
//                child: DropdownButton(
//                    items: List.generate(
//                      3,
//                          (index) => DropdownMenuItem(
//                        child: Text("In progress"),
//                      ),
//
//                    ),
//                    underline: Container()
//                    ,
//                    onChanged: (v) {}),
//              )
            ],
          ),
        ],
      ),
    );
  }
}