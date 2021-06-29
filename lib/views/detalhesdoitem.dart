import 'dart:typed_data';

import 'package:crud_firebase/canvas/canvas_screen-login.dart';
import 'package:crud_firebase/complements/convertedata.dart';
import 'package:crud_firebase/complements/convertereais.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetalhesDoItem extends StatefulWidget {
  DetalhesDoItem(
      {Key key,
      this.nome,
      this.descricao,
      this.un,
      this.valor,
      this.nomeFamilia,
      this.codReferencia,
      this.nomesTabelaDePreco,
      this.codDoProduto,
      this.nomeTabeladePrecoQueForSim,
      this.codNCM,
      this.unidadeDeMedida,
      this.custoLiquido,
      this.cadastroData,
      this.imgProduto});

  final String nome;
  final String descricao;
  final double un;
  final String valor;
  final String nomeFamilia;
  final String codReferencia;
  final List<String> nomesTabelaDePreco;
  final int codDoProduto;
  final String nomeTabeladePrecoQueForSim;
  final String codNCM;
  final String unidadeDeMedida;
  final double custoLiquido;
  final String cadastroData;
  final Uint8List imgProduto;

  @override
  _detalhesDoItem createState() => _detalhesDoItem();
}

class _detalhesDoItem extends State<DetalhesDoItem> {
  void initState() {
    super.initState();
  }

  get MediaWidth => MediaQuery.of(context).size.width;

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // TODO: implement build

    //Todo Ruan

    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromRGBO(36, 82, 108, 250),
        //Todo: cor da borda shadow, para ficar mesclado com o widget de filtro a baixo
        backgroundColor: Color.fromRGBO(36, 82, 108, 25),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Detalhes do Produto',
              style: TextStyle(color: Colors.white, fontSize: MediaWidth / 20),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width,
              // color: Colors.red,
              child: CustomPaint(
                //painter: BackgroundSignInDetahlesDoProduto(),
                child: Column(
                  children: [
                    Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 0, right: 0),
                          child: Container(
                            //color: Colors.blue,
                            child: ClipRRect(
                              child: widget.imgProduto.toString() != '[]'
                                  ? Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                          // color: Colors.red,
                                          image: DecorationImage(
                                              image: MemoryImage(
                                                  widget.imgProduto))))
                                  : Icon(
                                      Icons.image_not_supported_outlined,
                                      //Icons.image_not_supported_outlined,
                                      color: Colors.black12,
                                      size: MediaWidth / 2,
                                    ),
                              // TODO: Se a não tiver img, esse icon ser mostrado.
                            ),
                          ),
                        )),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${widget.nome}',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: MediaWidth / 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 2, top: 5),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //Text('R\$:', style: TextStyle(color: Colors.green, fontSize: MediaWidth/18),),
                        Row(
                          children: [
                            Text(
                              'R\$: ${converteReais(widget.valor)}',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: MediaWidth / 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Estoque: ',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize:
                                      MediaQuery.of(context).size.height / 50),
                            ),
                            Text(
                              '${widget.un.round()}',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: MediaWidth / 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    color: Colors.black12,
                    width: double.maxFinite,
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Text('Ref: ',
                                style: TextStyle(
                                    fontSize: MediaWidth / 22,
                                    color: Colors.black45)),
                            SelectableText(
                              '${widget.codReferencia}',
                              style: TextStyle(
                                  fontSize: MediaWidth / 22,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Row(
                          children: [
                            Text('Cód Prod:',
                                style: TextStyle(
                                    fontSize: MediaWidth / 22,
                                    color: Colors.black45)),
                            Text(
                              ' ${widget.codDoProduto} ',
                              style: TextStyle(
                                  fontSize: MediaWidth / 22,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Row(
                          children: [
                            Text('Familia: ',
                                style: TextStyle(
                                    fontSize: MediaWidth / 22,
                                    color: Colors.black45)),
                            widget.nomeFamilia != null
                                ? Text(
                                    '${widget.nomeFamilia}',
                                    style: TextStyle(
                                        fontSize: MediaWidth / 22,
                                        color: Colors.black87),
                                  )
                                : Text(
                                    'Familia não informada',
                                    style: TextStyle(
                                        fontSize: MediaWidth / 22,
                                        color: Colors.black45),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Row(
                          children: [
                            Text('NCM :',
                                style: TextStyle(
                                    fontSize: MediaWidth / 22,
                                    color: Colors.black45)),
                            Text(
                              ' ${widget.codNCM.toString()}',
                              style: TextStyle(
                                  fontSize: MediaWidth / 22,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Row(
                          children: [
                            Text('Un Medida: ',
                                style: TextStyle(
                                    fontSize: MediaWidth / 22,
                                    color: Colors.black45)),
                            Text(
                              '${widget.unidadeDeMedida}',
                              style: TextStyle(
                                  fontSize: MediaWidth / 22,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Row(
                          children: [
                            Text('Líquido:',
                                style: TextStyle(
                                    fontSize: MediaWidth / 22,
                                    color: Colors.black45)),
                            Text(
                              ' R\$ ${converteReais(widget.custoLiquido)}',
                              style: TextStyle(
                                  fontSize: MediaWidth / 22,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Row(
                          children: [
                            Text(
                              'Cadastro: ',
                              style: TextStyle(
                                  fontSize: MediaWidth / 22,
                                  color: Colors.black45),
                            ),
                            Text(
                              ' ${converteData(widget.cadastroData)}',
                              style: TextStyle(
                                fontSize: MediaWidth / 22,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10),
                        child: Container(
                          width: MediaWidth,
                          child: Text(
                            'Tabela de preços:',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black45
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaWidth - 20,
                        color: Colors.white10,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black12,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: DropdownButton<String>(
                            icon: Container(
                              //color: Colors.red,
                              child: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 40,
                                color: Colors.black87,
                              ),
                            ),
                            underline: Container(
                              height: 0,
                            ),
                            value: widget.nomeTabeladePrecoQueForSim,
                            onChanged: (String string) => setState(() {}),
                            selectedItemBuilder: (BuildContext context) {
                              return widget.nomesTabelaDePreco
                                  .map<Widget>((String item) {
                                return Container(
                                  width: 300,
                                  // color: Colors.orange,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Center(
                                      child: Text(
                                        '       $item',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: MediaWidth / 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                            items: widget.nomesTabelaDePreco.map((String item) {
                              return DropdownMenuItem<String>(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: MediaWidth / 1.1,
                                          height: 45,
                                          child: Center(
                                            child: Text(
                                              '$item',
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                fontSize: MediaWidth / 22,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 5,
                                        bottom: 5,
                                      ),
                                      child: Container(
                                        height: 1,
                                        width: double.infinity,
                                        color: Colors.black12,
                                      ),
                                    )
                                  ],
                                ),
                                value: item,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
