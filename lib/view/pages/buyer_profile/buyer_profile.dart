import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/job/widgets.dart';
import 'package:freelance_app/view/widgets/back_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class BuyerProfile extends StatelessWidget {
  const BuyerProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Back',
        ),
        leading: CustomBackButton(),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Image.asset(
              'assets/images/edit.png',
              width: 25,
              height: 25,
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                    'William Chase',
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
                    text: '47 jobs',
                  ),
                  UserInfoWidget(
                    icon: Icons.star,
                    text: '4.9',
                  ),
                  UserInfoWidget(
                    icon: Icons.location_on,
                    text: '1.7 miles away',
                  )
                ],
              ),
              Headline(text: 'Latest Reviews'),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: SizedBox(
                width: Dimensions.width(90),
                child: ListView.builder(
                  itemBuilder: (context, index) => Review(
                    reviewText: "Nince person to work for",
                    rating: 4.5,
                    userProfile: "assets/images/profile.png",
                  ),
                  itemCount: 10,
                  shrinkWrap: true,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class Review extends StatelessWidget {
  final String reviewText;
  final double rating;
  final String userProfile;
  const Review({
    Key key,
    @required this.reviewText,
    @required this.rating,
    @required this.userProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: Dimensions.height(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 0),
                blurRadius: 5)
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(userProfile),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SmoothStarRating(
                rating: rating,
                allowHalfRating: true,
                starCount: 5,
                color: primary,
                filledIconData: Icons.star,
                
                onRated: (r){},
              ),
              Text(reviewText)
            ],
          )
        ],
      ),
    );
  }
}
