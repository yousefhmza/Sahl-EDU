import 'package:flutter/material.dart';

final Size size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
final double deviceHeight = size.height;
final double deviceWidth = size.width;

class AppPadding {
  static const double p8 = 8.0;
  static const double p10 = 10.0;
  static const double p16 = 16.0;
  static const double p24 = 24.0;
  static const double p52 = 52.0;
}

class AppSize {
  static const double s0 = 0.0;
  static const double s1 = 1.0;
  static const double s2 = 2.0;
  static const double s3 = 3.0;
  static const double s4 = 4.0;
  static const double s8 = 8.0;
  static const double s12 = 12.0;
  static const double s16 = 16.0;
  static const double s20 = 20.0;
  static const double s24 = 24.0;
  static const double s32 = 32.0;
  static const double s56 = 56.0;
  static const double s100 = 100.0;
}

class Time {
  static const Duration t150 = Duration(milliseconds: 150);
  static const Duration t2000 = Duration(milliseconds: 2000);
  static const Duration longTime = Duration(minutes: 10);
}
