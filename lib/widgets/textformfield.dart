import 'package:flutter/material.dart';
import '../template/theme.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String label;
  final IconData icon;
  final bool enabled;
  final Function onChanged;

  MyTextField({
    @required this.controller,
    @required this.type,
    @required this.label,
    @required this.icon,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(40, 15, 40, 15),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 18,
            fontFamily: 'IranYekanFN',
            color: orange,
          ),
          contentPadding: EdgeInsets.all(20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: orange,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(
            icon,
            size: 20,
            color: orange,
          ),
        ),
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'IranYekanFN',
          color: greyMedium,
        ),
        autofocus: false,
        enabled: enabled,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
        cursorColor: greyLight,
        controller: controller,
        keyboardType: type,
        onChanged: onChanged,
        // autovalidate: true,
        // validator: (text) {},
      ),
    );
  }
}
