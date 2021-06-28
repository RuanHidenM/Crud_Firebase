import 'package:flutter/material.dart';


  Widget circularButtonMediunTitleColorIcon ({
  Color corDobotao = Colors.white,
  IconData iconDoBotao = Icons.warning_amber_outlined,
  Color corDoIcon = Colors.black
}){
    return  Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: corDobotao,
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        child: Icon(iconDoBotao, color: corDoIcon,)
    );
  }
