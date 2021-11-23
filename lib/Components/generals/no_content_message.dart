import 'package:flutter/material.dart';

class NoContentMessage extends StatelessWidget {
  final IconData icone;
  final String texto;

  NoContentMessage(this.texto, {this.icone});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: icone != null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icone,
                size: 56.0,
              ),
            ),
          ),
          Text(
            texto,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
