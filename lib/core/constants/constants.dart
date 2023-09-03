import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kPrimaryColor = const Color(0xFF0258DD);
Color kAppBgColor = const Color(0xFFFAFAFA);
Color kGreyColor = const Color(0xFFD9D9D9);
Color kBlackColor = const Color(0xFF1C1D1E);
Color kDarkGreyColor = const Color(0xFF8E8E8E);
Color kGrey = const Color(0xFFB3B3B3);
Color kLightGreyColor = const Color(0xFFD9D9D9);

Color kSuccessColor = const Color.fromARGB(255, 96, 231, 7);
Color kWarnningColor = const Color.fromARGB(255, 253, 167, 19);
Color kErrorColor = const Color.fromARGB(255, 207, 22, 22);

Color kButtonPrimaryColor = kPrimaryColor;
Color kButtonTextWhiteColor = const Color(0xFFFFFFFF);
Color kButtonTextBlueColor = const Color(0xFF0258DD);

Color kInputFieldBgColor = const Color(0xFFF2F3F5);
Color kInputFieldHintTextColor = const Color(0xFFA6A6A6);

//filled buttons text style
TextStyle kFilledButtonTextstyle = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: kButtonTextWhiteColor,
);
//outlined buttons text style
TextStyle kOutlineButtonTextstyle = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: kButtonTextBlueColor,
);
//black small text style
TextStyle kDarkGreySmalltextStyle = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: kDarkGreyColor,
);
//Dark grey small text style
TextStyle kBlackSmalltextStyle = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: kDarkGreyColor,
);
//primary color small text
TextStyle kBlueSmalltextStyle = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: kPrimaryColor,
);

//Dark grey small text style
TextStyle kInputFieldHintText = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: kInputFieldHintTextColor,
);
//black input field text style
TextStyle kInputFieldText = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: kBlackColor,
);

//black input field text style
TextStyle kwarningText = GoogleFonts.poppins(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: kErrorColor,
);

//headding text style
TextStyle kTitleOneText = GoogleFonts.poppins(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: kPrimaryColor,
);
