import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showFlutterToast(String meg, Color backgoroundColor) =>
    Fluttertoast.showToast(
      msg: meg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgoroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
