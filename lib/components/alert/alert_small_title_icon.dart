
import 'package:flutter/material.dart';


//TODO: Um alerta de tamanho pequeno, apenas para informa o usuario, sem função
void AlertaSimples(context,String nameTitle, String message, IconData iconDeAlert) {

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(nameTitle),
          content: IntrinsicHeight (
            child: Column(
              children: [
                Icon(iconDeAlert, color: Colors.deepOrange, size: 55),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(message),
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      });
}

void AlertaSuccess(context,String nameTitle, String message, IconData iconDeAlert) {

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(nameTitle),
          content: IntrinsicHeight (
            child: Column(
              children: [
                Icon(iconDeAlert, color: Colors.green, size: 55),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(message),
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      });
}