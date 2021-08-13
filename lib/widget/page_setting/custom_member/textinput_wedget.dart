import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget TextInput(
    TextEditingController controller, String label, IconData iconData) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20, top: 5),
    padding: EdgeInsets.only(left: 20),
    child: TextFormField(
      controller: controller,
      cursorHeight: 30,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 25, color: Colors.black),
        border: InputBorder.none,
        icon: Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    ),
  );
}
