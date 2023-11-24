import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  Color blueColor = const Color(0XFF3c3ccd);

  textStyle() {
    return const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500);
  }

  inputDecorationWithLabel(hint, borderColor, {image, onTap, borderRadius}) {
    return InputDecoration(
      hintStyle: textStyle(),
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 50.0),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 50.0),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 50.0),
        borderSide: BorderSide(color: borderColor),
      ),
      suffixIcon: InkWell(onTap: onTap, child: Transform.scale(scaleX: -1, child: Icon(image, size: 25.0, color: blueColor))),
    );
  }

  showToast(text) {
    return Fluttertoast.showToast(msg: text, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, fontSize: 16.0);
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      content: SizedBox(
        height: 50.0,
        width: 50.0,
        child: Center(child: CircularProgressIndicator(backgroundColor: Colors.white, color: blueColor)),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
