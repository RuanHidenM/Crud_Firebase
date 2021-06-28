import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfigScreen extends StatefulWidget{
  @override
  _configScreen createState() => _configScreen();
}

class _configScreen extends State<ConfigScreen> {
  get MediaWidth => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromRGBO(36, 82, 108, 250),
        //Todo: cor da borda shadow, para ficar mesclado com o widget de filtro a baixo
        backgroundColor: Color.fromRGBO(36, 82, 108, 25),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Configurações',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        // Text('Produtos', style: TextStyle(color: Colors.white)),
      ),
      body:Container(
        child: Center(
            child: Text(
                'Configurações',
                style: TextStyle(
                color: Colors.black12,
                fontSize: MediaWidth / 15
            ),
          ),
        ),
      ),
    );
  }
}