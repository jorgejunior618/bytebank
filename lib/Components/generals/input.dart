import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input({
    this.labelText,
    this.hint,
    this.isName: false,
    this.isNumber: false,
    this.isEmail: false,
    this.controller,
    this.prefix,
    this.icon,
  });

  TextInputType getKeyboardType() {
    return isNumber
        ? TextInputType.number
        : isName
            ? TextInputType.name
            : isEmail
                ? TextInputType.emailAddress
                : TextInputType.text;
  }

  TextCapitalization getCapitalization() {
    return !isNumber ? TextCapitalization.sentences : TextCapitalization.none;
  }

  final IconData icon;
  final String prefix;
  final String labelText;
  final String hint;
  final bool isName;
  final bool isNumber;
  final bool isEmail;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 20.0,
        ),
        decoration: InputDecoration(
            icon: icon != null ? Icon(icon) : null,
            prefix: prefix != null ? Text(prefix) : null,
            labelText: labelText,
            hintText: hint,
            contentPadding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
            labelStyle: TextStyle(
              fontSize: 20.0,
            )),
        textCapitalization: getCapitalization(),
        keyboardType: getKeyboardType(),
      ),
    );
  }
}
