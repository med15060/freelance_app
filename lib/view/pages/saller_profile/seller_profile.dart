import 'package:flutter/material.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';
import 'package:freelance_app/view/pages/profile/widgets.dart';
import 'package:freelance_app/view/widgets/appbar.dart';
import 'package:freelance_app/view/widgets/back_button.dart';
import 'package:freelance_app/view/widgets/carousel.dart';
import 'package:freelance_app/view/widgets/circular_border_button.dart';
import 'package:freelance_app/view/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:freelance_app/main.dart';

class SellerProfile extends StatelessWidget {
  const SellerProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar.appbar(
        "Buyer Profile",
//        leading: CustomBackButton(),
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      'assets/images/profile.png',
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                       myUser.name,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
//                      Text("Repaires")
                    ],
                  )
                ],
              ),
              Headline(text: "Information"),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  UserInfoWidget(
                    icon: Icons.work,
                    text: myUser.how_many_jobs,
                  ),
                  UserInfoWidget(
                    icon: Icons.star,
                    text: myUser.stars_value,
                  ),
                  UserInfoWidget(
                    icon: Icons.location_on,
                    text: "1.2 miles away",
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
//              CustomTextField(
//                height: Dimensions.height(80),
//                width: Dimensions.width(90),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: <Widget>[
//                    Align(
//                        alignment: Alignment.centerLeft,
//                        child: Headline(text: "Description")),
//                    Text(
//                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet.",
//                    ),
//                    SizedBox(
//                      height: 20,
//                    ),
//                    Center(
//                      child: CustomCarousel(
//                        images: ["assets/images/fix.jpg"],
//                      ),
//                    ),
//                   SizedBox(
//                     height: Dimensions.height(10),
//                   ),
//                    RoundedCornerButton(
//                      text: "Fix",
//                      onPress: () {},
//                      width: Dimensions.width(60),
//                    ),
//                    SizedBox(
//                      height: 80,
//                    )
//                  ],
//                ),
//              )
            ],
          ),
        ),
      ),
    );
  }
}
