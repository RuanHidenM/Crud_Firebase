import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String message;

  Progress({this.message = 'Carregando...'});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text(message,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),)
          ],
        ),
      ),
    );
  }
}
