import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/utils/screen_dimensions_helper.dart';

class CustomCarousel extends StatelessWidget {
  final List<String> images;
  const CustomCarousel({Key key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Dimensions.height(20),
        width: Dimensions.width(80),
        child: Carousel(
          autoplay: false,
          borderRadius: true,
          radius: Radius.circular(20),
          dotSize: 4,
          boxFit: BoxFit.fill,
          
          dotBgColor: Colors.transparent,
          dotIncreasedColor: primary,
          images: List.generate(
            images.length,
            (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(
                      images[index],
                    ),
                    fit: BoxFit.fill),
              ),
            ),
          ),
        ));
  }
}
