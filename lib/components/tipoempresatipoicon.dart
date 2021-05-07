
import 'package:flutter/material.dart';

TipoEmpresaTipoIcon(int tipo) {

  if(tipo == 1){
    return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, right:25, left:8),
        child: Icon(Icons.move_to_inbox_outlined, size: 35, color: Colors.indigo,)
    );
  }
  if(tipo == 2){
    return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, right:25, left:8),
        child: Icon(Icons.account_balance_outlined, size: 35, color: Colors.indigo)
    );
  }
  if(tipo != 1 && tipo != 2){
    return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, right:25, left:8),
        child: Icon(Icons.remove, size: 35, color: Colors.indigo)
    );
  }
}