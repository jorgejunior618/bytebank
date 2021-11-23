import 'package:flutter/material.dart';

class Buttom extends StatelessWidget {
  Buttom({
    this.buttomTitle,
    this.onPress,
  });

  final String buttomTitle;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: onPress,
          child: Text(
            buttomTitle,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
