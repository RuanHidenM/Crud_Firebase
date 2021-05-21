import 'package:crud_firebase/views/drawerside.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  _homePage createState() => _homePage();
}

class _homePage extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:DrawerSide(),
      appBar: AppBar(
        shadowColor: Color.fromRGBO(36, 82, 108, 250),
        //Todo: cor da borda shadow, para ficar mesclado com o widget de filtro a baixo
        backgroundColor: Color.fromRGBO(36, 82, 108, 25),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),

        // Text('Produtos', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: Center(
          child: Text('Home Page'),
        )
      ),
    );
  }
}
