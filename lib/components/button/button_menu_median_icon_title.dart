
import 'package:flutter/material.dart';

class ButtonMenuMedianIconTitle extends StatelessWidget {
  ButtonMenuMedianIconTitle(this.title, this.icon, this.segundoIcon);
  final String title; //TODO: Titulo do butão
  final IconData icon; //TODO: Icone do botão
  final IconData segundoIcon; //TODO: Icone do botão
  //final Color cordefundo;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(12, 0, 0, 0),
          border: Border(
            left: BorderSide(width: 3, color: Colors.orange)
          ),
        ),
          height: 80,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Icon(icon,
                        size: 45,
                        color: Colors.indigo
                    ),
                  ),
                Container(
                    child: Text(title, style: TextStyle(
                        fontSize: 20
                    ),
                  ),
                ),
                Container(
                  child: Icon(segundoIcon,
                      size: 45,
                      color: Colors.indigo
                  ),
                ),
              ],
            ),
          ),
        );
    }
}
