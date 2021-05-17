import 'package:flutter/material.dart';


  Widget CircularButtonBiglTitleColorIconConectState ({
  Color corDobotao = Colors.white,
  IconData iconDoBotao = Icons.warning_amber_outlined,
  Color corDoIcon = Colors.black,
  bool ConectState,
}){
    return  Container(
        height: 75,
        width: 75,
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(

          border: Border.all(
              color: ConectState == false ? Colors.red : Colors.green
          ),
          color: corDobotao,
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        child:Icon(
              iconDoBotao,
              color: corDoIcon,
              size: 45,
          ),
    );
  }
