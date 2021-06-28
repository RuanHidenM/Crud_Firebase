import 'package:flutter/material.dart';


  Widget circularButtonBiglTitleColorIcon ({
  Color corDobotao = Colors.white,
  IconData iconDoBotao = Icons.warning_amber_outlined,
  Color corDoIcon = Colors.black
}){
    return  Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          color: corDobotao,
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        child: Icon(iconDoBotao, color: corDoIcon, size: 45,)
    );
  }
