import 'package:flutter/material.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:get/get.dart';

class Dimensions {
  static final Dimensions _dimensions = Dimensions._();
  factory Dimensions() {
    return _dimensions;
  }
  Dimensions._();
  static Function get width => Screen(MediaQuery.of(Get.context).size).wp;
  static Function get height => Screen(MediaQuery.of(Get.context).size).hp;
}
