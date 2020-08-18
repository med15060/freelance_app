import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';

class UserInfoWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const UserInfoWidget({
    Key key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // Image.asset(
        //   'assets/images/$iconUrl',
        //   width: 20,
        //   height: 20,
        // ),
        Icon(
          icon,
          color: primary,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: GoogleFonts.openSans(color: fontColor, fontSize: 16).apply(),
        )
      ],
    );
  }
}

class Specialize extends StatelessWidget {
  final String text;
  final Color color;
  const Specialize({Key key, @required this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: Dimensions.height(5),
      width: Dimensions.width(30),
      decoration: BoxDecoration(
          border: color != null ? Border.all(color: Colors.black) : null,
          color: color ?? primary.withOpacity(.3),
          borderRadius: BorderRadius.circular(4)),
      child: Center(
          child: Text(text, style: GoogleFonts.openSans(fontSize: 16).apply())),
    );
  }
}

class Reviews extends StatelessWidget {
  final double reviewValue;
  final String reviewText;

  const Reviews({
    Key key,
    @required this.reviewValue,
    @required this.reviewText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: Dimensions.width(80),
      decoration: BoxDecoration(
          color: background,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 0),
                blurRadius: 5)
          ],
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: <Widget>[
        /*  CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),**/
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SmoothStarRating(
                allowHalfRating: true,
                color: primary,
                rating: reviewValue,
                size: 20,
                starCount: 5,

              ),
              SizedBox(width: Dimensions.width(60), child: Text(reviewText))
            ],
          )
        ],
      ),
    );
  }
}

class Headline extends StatelessWidget {
  final String text;
  const Headline({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

class JobWidget extends StatelessWidget {
  final String description;
  final String jobTitle;
  const JobWidget({
    Key key,
    @required this.description,
    @required this.jobTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: Dimensions.width(70),
      height: Dimensions.height(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          color: background,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 5,
              color: Colors.black.withOpacity(0.1),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            child: Icon(Icons.work),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(jobTitle),
              SizedBox(
                height: 10,
              ),
              Text(description),
            ],
          )
        ],
      ),
    );
  }
}