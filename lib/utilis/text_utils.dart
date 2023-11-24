import 'package:flutter/material.dart';

class TextUtils {
  Text txt10({required String text, Color? color, FontWeight? fontWeight, TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(color: color ?? Colors.black, fontSize: 10, fontWeight: fontWeight),
    );
  }

  Text txt12({required String text, Color? color, FontWeight? fontWeight, TextAlign? textAlign, int? maxLines}) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color ?? Colors.black, fontSize: 12, fontWeight: fontWeight),
    );
  }

  Text txt14({required String text, Color? color, FontWeight? fontWeight, TextAlign? textAlign, textDecoration, int? maxLines}) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color ?? Colors.black, fontSize: 14, fontWeight: fontWeight, decoration: textDecoration),
    );
  }

  Text txt16(
      {required String text,
      Color? color,
      FontWeight? fontWeight,
      TextAlign? textAlign,
      TextDecoration? textDecoration,
      Color? decorationColor,
      int? maxLines,
      TextDecorationStyle? textDecorationStyle,
      double? decorationThickness}) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
          color: color ?? Colors.black,
          fontSize: 16,
          fontWeight: fontWeight,
          decoration: textDecoration,
          decorationColor: decorationColor,
          decorationStyle: textDecorationStyle,
          decorationThickness: decorationThickness),
    );
  }

  Text txt18({required String text, Color? color, FontWeight? fontWeight, TextAlign? textAlign, TextDecoration? textDecoration, int? maxLines}) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color ?? Colors.black, fontSize: 18, fontWeight: fontWeight, decoration: textDecoration),
    );
  }

  Text txt20({required String text, Color? color, FontWeight? fontWeight, TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(color: color ?? Colors.black, fontSize: 20, fontWeight: fontWeight),
    );
  }

  Text txt22({required String text, Color? color, FontWeight? fontWeight, TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(color: color ?? Colors.black, fontSize: 22, fontWeight: fontWeight),
    );
  }

  Text txt24({required String text, Color? color, FontWeight? fontWeight, TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(color: color ?? Colors.black, fontSize: 24, fontWeight: fontWeight),
    );
  }

  Text txt26({required String text, Color? color, FontWeight? fontWeight, TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(color: color ?? Colors.black, fontSize: 26, fontWeight: fontWeight),
    );
  }

  Text txt28({required String text, Color? color, FontWeight? fontWeight, TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(color: color ?? Colors.black, fontSize: 28, fontWeight: fontWeight),
    );
  }

  Text txt30({required String text, Color? color, FontWeight? fontWeight, TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(color: color ?? Colors.black, fontSize: 30, fontWeight: fontWeight),
    );
  }

  Text txtDynamic(
      {required String text, required double fontSize, Color? color, double? height, FontWeight? fontWeight, TextAlign? textAlign, int? maxLines}) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color ?? Colors.black, height: height, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
