import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  final String message;
  final IconData icon;
  final double iconSize;
  final double fontSize;

  CenteredMessage(
    this.message, {
    this.icon,
    this.iconSize = 64,
    this.fontSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(

          width: double.maxFinite,
          color: Color.fromRGBO(142, 142, 142, 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Visibility(
                child: Icon(
                  icon,
                  size: iconSize,
                  color: Colors.black38,
                ),
                visible: icon != null,
              ),
              Container(
                height: 160,
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    message,
                    style: TextStyle(fontSize: fontSize, color: Colors.black38),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
