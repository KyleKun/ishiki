import 'package:flutter/material.dart';
import 'package:flutter_web_buttons/flutter_web_buttons.dart';

class AppTextStyles {
  static TextStyle mainTitle = const TextStyle(
    fontSize: 144,
    fontWeight: FontWeight.bold,
    letterSpacing: 20.0,
    color: Colors.white,
    fontFamily: '1bit',
  );

  static TextStyle common = const TextStyle(
    fontSize: 30,
    color: Colors.white,
    fontFamily: '1bit',
  );

  static TextStyle dialogue({required double height}) => TextStyle(
        fontSize: height * 0.07,
        color: Colors.white,
        fontFamily: '1bit',
      );

  static FlutterWebButtonOptions button({
    required double width,
    required double height,
  }) =>
      FlutterWebButtonOptions(
        buttonWidth: width,
        buttonHeight: height,
        fontSize: 32,
        textColor: Colors.black,
        fontFamily: '1bit',
        buttonBackgroundColor: Colors.white,
        buttonBorderColor: Colors.black,
        buttonBorderWidth: 4.0,
      );

  static FlutterWebButtonOptions ksp({
    required double width,
    required double height,
  }) =>
      FlutterWebButtonOptions(
        buttonWidth: width,
        buttonHeight: height,
        fontSize: 28,
        textColor: Colors.black,
        fontFamily: '1bit',
        buttonBackgroundColor: Colors.white,
        buttonBorderColor: Colors.white,
      );
}
