import 'package:flutter/material.dart';

  @override
  Widget buttonSmallTitleIconColor
  ({
    String name = 'Button',
    IconData iconDoButton = Icons.warning_amber_outlined,
    Color corDoBotao = Colors.white,
    Color corDoTexto = Colors.black,
    Color corDoIcon = Colors.black,
  }) {
      return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 55,
              width: 120,
              decoration: BoxDecoration(
                color: corDoBotao,
                borderRadius: BorderRadius.all(
                  Radius.circular(80),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(name,
                      style: TextStyle(
                        fontSize: 18,
                        color: corDoIcon,
                      ),),
                  ),
                  Icon(iconDoButton,
                    size: 20,
                    color: corDoIcon,)
                ],
              ),
            ),
          )
      );
  }