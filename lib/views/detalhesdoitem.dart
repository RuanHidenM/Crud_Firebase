import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetalhesDoItem extends StatefulWidget{
  @override
  _detalhesDoItem createState() => _detalhesDoItem();
}

class _detalhesDoItem extends State<DetalhesDoItem>{
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
              'Detahles do trudo',
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(Icons.filter_list_rounded,
                  color: Colors.white, size: 25),
            ),
          ],
        ),
      ),
        body: Center(child: Text('Detalhes do produtoss'),),
    );
  }
}