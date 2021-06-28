
import 'package:flutter/material.dart';


//TODO: Um alerta de tamanho pequeno, apenas para informa o usuario, sem função
void alertaSimples(context,String nameTitle, String message, IconData iconDeAlert, Color coricon) {

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(nameTitle),
          content: IntrinsicHeight (
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(iconDeAlert, color: coricon, size: 55),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(message, textAlign:TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      });
}

void alertaSuccess(context,String nameTitle, String message, IconData iconDeAlert) {

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
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      });
}