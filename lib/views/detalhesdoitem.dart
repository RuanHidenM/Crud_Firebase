import 'package:crud_firebase/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetalhesDoItem extends StatefulWidget{
  DetalhesDoItem({Key key, this.nome, this.descricao, this.un, this.valor});

  final String nome;
  final String descricao;
  final int un;
  final double valor;

  @override
  _detalhesDoItem createState() => _detalhesDoItem();
}
class _detalhesDoItem extends State<DetalhesDoItem>{

  get MediaWidth => MediaQuery.of(context).size.width;

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
              'Detalhes do Item',
              style: TextStyle(color: Colors.white, fontSize: MediaWidth / 23),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(Icons.filter_list_rounded,
                  color: Colors.white, size: 25),
            ),
          ],
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: const Offset(
                    1.0,
                    1.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color:  Color.fromRGBO(36, 82, 108, 25),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Center(child: Text(widget.nome, style: TextStyle(fontSize: MediaWidth/ 23, color: Colors.white),)),
                    ),
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(top:10.0),
                      child: Container(
                        //color: Colors.yellow,
                        height: MediaWidth/ 2,
                        child: Center(
                          child: ClipRRect(
                            child: Image.asset(widget.nome == 'Achocolatado Po Nescau 2.0' ? 'images/nescal.png' :
                            widget.nome == 'Biscoito Recheado com creme' ? 'images/bolacha.png' : 'images/achocolatado.png'),
                          ),
                        ),
                      ),
                    )
                ),
                Expanded(
                  flex: 11,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      // color: Colors.blue,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5,bottom: 10),
                                child: Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Color.fromRGBO(36, 82, 108, 25),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom:5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Descrição:',style: TextStyle(fontSize: MediaWidth/ 28, color: Colors.black45)),
                                    Padding(
                                      padding: const EdgeInsets.only(left:8.0, right: 8.0),
                                      child: Row(
                                        children: [
                                          Flexible(child: Text(widget.descricao, style: TextStyle(fontSize: MediaWidth/ 28, color: Colors.black87))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5),
                                child: Row(
                                  children: [
                                    Text('Famámilia :',style: TextStyle(fontSize: MediaWidth/ 28, color: Colors.black45)),
                                    Text(' Doces e Salgados', style: TextStyle(fontSize: MediaWidth/ 28, color: Colors.black87),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5),
                                child: Row(
                                  children: [
                                    Text('Quantidade :',style: TextStyle(fontSize: MediaWidth/ 28, color: Colors.black54)),
                                    Text(widget.un.toString(), style: TextStyle(fontSize: MediaWidth/ 28, color: Colors.black87)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5),
                                child: Row(
                                  children: [
                                    Text('Custo Fornecedor :',style: TextStyle(fontSize: MediaWidth/ 28, color: Colors.black54)),
                                    Text(' R\$: ${widget.valor}', style: TextStyle(fontSize: MediaWidth/ 28, color: Colors.black87)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5),
                                child: Row(
                                  children: [
                                    Text('Tabela de Preço :',style: TextStyle(fontSize: MediaWidth/ 28, color: Colors.black54)),
                                    Text('  R\$:15,90', style: TextStyle(fontSize: MediaWidth/ 28,)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5),
                                child: Row(
                                  children: [
                                    Text('Unidade de Medida :',style: TextStyle(fontSize: MediaWidth/ 28, color: Colors.black54)),
                                    Text(' Gramas', style: TextStyle(fontSize: MediaWidth/ 28,)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}