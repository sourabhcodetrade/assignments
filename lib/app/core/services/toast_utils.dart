import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class ToastUtils {
  static void success(final String message) => Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.green[300],
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
  static void failure(final String message) => Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
      );
}
