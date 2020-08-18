import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/widgets/text_field.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

showReviewDialog(context) {
  showDialog(
      context: (context),
      barrierDismissible: true,
      builder: (context) => Dialog(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomTextField(
                    expandes: true,
                    height: Dimensions.height(20),
                    hint: "Review Description",
                  ),
                  ReviewItem(text: "Communication", rating: 0),
//                  ReviewItem(text: "service", rating: 0),
//                  ReviewItem(text: "Buy Again", rating: 0),

                ],
              ),
            ),
          ));
}

class ReviewItem extends StatelessWidget {
  final String text;
  final double rating;
  const ReviewItem({
    Key key,
    @required this.text,
    @required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(text),
          Expanded(child: SizedBox()),
          SmoothStarRating(
            rating: rating,
            allowHalfRating: true,
            color: primary,
          )
        ],
      ),
    );
  }
}
