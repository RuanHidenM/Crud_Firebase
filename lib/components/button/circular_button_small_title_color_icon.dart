import 'package:flutter/material.dart';


  Widget CircularButtonSmallTitleColorIcon ({
  Color corDobotao = Colors.white,
  IconData iconDoBotao = Icons.warning_amber_outlined,
  Color corDoIcon = Colors.black
}){
    return  Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: corDobotao,
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        child: Icon(iconDoBotao, color: corDoIcon,)
    );
  }
