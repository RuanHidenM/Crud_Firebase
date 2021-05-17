import 'package:flutter/material.dart';

Widget myTextField
({
  @required String titleName,                 //TODO:Nome do campo.                                                         //TODO:titleName: 'name',
  @required String descriptionName,           //TODO:Descrição do campo.                                                    //TODO:descriptionName: 'Enter with your name',
  Function changeTypeName,                    //TODO:(text){buscaUser.name = text;},                                        //TODO:changeTypeName: (text){buscaUser.name = text;},
  TextInputType typeKeyBoard,                 //TODO:TextInputType.emailAddress,:Tipo do teclado do campo.                                              //TODO:typeKeyBoard: TextInputType.name,
  TextEditingController nomeDoComtrolador,    //TODO:Nome do comtrolador.                                                   //TODO:nomeDoComtrolador: _nameController,
  TextTipeMask,                               //TODO:Mascara que deve ser printada no textfield, pode ser passada com null  //TODO:TextTipeMask: null,
  Color colorTextField = Colors.white,
  bool obscureText = false,                   //TODO:Usado em campos de senha
}) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
           // BoxShadow(color: Colors.grey, spreadRadius: 0.1)
          ],
           // color: Color.fromRGBO(46, 76, 147, 230),
          color:colorTextField,
            borderRadius:
            BorderRadius.all(
              Radius.circular(100),
            ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 1.0, bottom: 1.0, left: 25, right: 25),
          child: TextField(
            cursorColor: Color.fromRGBO(74, 184, 239, 1),
            onChanged: changeTypeName,
            inputFormatters: TextTipeMask,
            keyboardType: typeKeyBoard,
            controller: nomeDoComtrolador,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,//TODO:Remove a borda padrão do textField.
              labelStyle: TextStyle(
                color: Colors.black54,
              ),
              labelText: titleName,
              hintText: descriptionName,

            ),
          ),
        ),
      ),
    ),
  );
}
