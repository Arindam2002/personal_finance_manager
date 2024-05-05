import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Colors
Color kPrimaryColor = const Color(0xFF181d1c);
Color kPrimaryLightColor = const Color(0xFF1b2a27);
Color kPrimaryTextColor = const Color(0xFFf0f0f0);
Color kCardDarkColor = const Color(0xFF282f2b);
Color kGreyColor = const Color(0xFF929293);
Color kGoalsCardColor = const Color(0xFF3e544d);
Color kGoalProgressIndicatorColor = const Color(0xFF6ef07b);
MaterialColor kPrimarySwatch = MaterialColor(
  kPrimaryColor.value,
  <int, Color>{
    50: kPrimaryColor.withOpacity(0.1),
    100: kPrimaryColor.withOpacity(0.2),
    200: kPrimaryColor.withOpacity(0.3),
    300: kPrimaryColor.withOpacity(0.4),
    400: kPrimaryColor.withOpacity(0.5),
    500: kPrimaryColor.withOpacity(0.6),
    600: kPrimaryColor.withOpacity(0.7),
    700: kPrimaryColor.withOpacity(0.8),
    800: kPrimaryColor.withOpacity(0.9),
    900: kPrimaryColor.withOpacity(1.0),
  },
);

// BoxDecoration
BoxDecoration kScaffoldDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [kPrimaryLightColor, kPrimaryColor],
  ),
);