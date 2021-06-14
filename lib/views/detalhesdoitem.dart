import 'package:crud_firebase/canvas/canvas_screen-login.dart';
import 'package:crud_firebase/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      this.codNCM
      });

  final String nome;
  final String descricao;
  final String un;
  final String valor;
  final String nomeFamilia;
  final String codReferencia;
  final List<String> nomesTabelaDePreco;
  final int codDoProduto;
  final String nomeTabeladePrecoQueForSim;
  final String codNCM;


  @override
  _detalhesDoItem createState() => _detalhesDoItem();
}

class _detalhesDoItem extends State<DetalhesDoItem> {
  void initState() {
    super.initState();
  }

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
                'Detalhes do Produto',
                style:
                    TextStyle(color: Colors.white, fontSize: MediaWidth / 20),
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
                  painter: BackgroundSignInDetahlesDoProduto(),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 0, right: 0),
                            child: Container(
                              //color: Colors.blue,
                              child: ClipRRect(
                                child: widget.nome ==
                                        'CAPAC. ELET. IMPORT. -  1.000 MF  X   16 V - RADIAL'
                                    ? Image.asset('cap.png')
                                    : widget.nome ==
                                            'COMPUTADOR LIVA ZE INTEL WINDOWS ULN3350430W DUAL CORE N3350 4GB SSD 30GB HDMI USB REDE WINDOWS 10'
                                        ? Image.asset('comp-live.png')
                                        : widget.nome ==
                                                'NOTEBOOK LENOVO 33015IKB I37020U4GB SSD 120GB'
                                            ? Image.asset('note-lenovo.png')
                                            : widget.nome ==
                                                    'NOTE ACER A315 I3 15.6 8GB SSD 240GB  W10'
                                                ? Image.asset('note-acer.png')
                                                : Icon(
                                                    Icons.image_outlined,
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
              padding: const EdgeInsets.only(left: 5, right: 5),
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
                              Icon(
                                Icons.attach_money,
                                color: Colors.green,
                                size: MediaWidth / 14,
                              ),
                              Text(
                                '${widget.valor}',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: MediaWidth / 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                  Icons.code,
                                  color: Colors.black45, size: MediaWidth / 13),
                              Text(
                                ' ${widget.codDoProduto}',
                                 style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: MediaWidth / 18),
                              ),
                            ],
                          )
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
                    padding: const EdgeInsets.only(left: 10, right: 10,top: 3),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Text('Estoque:',
                                  style: TextStyle(
                                      fontSize: MediaWidth / 22,
                                      color: Colors.black45)),
                              Text(
                                ' ${widget.un} ',
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
                    padding: const EdgeInsets.only(left: 10, right: 10,top: 3),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
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
                    padding: const EdgeInsets.only(left: 10, right: 10,top: 3),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Text('Cód. Ref:',
                                  style: TextStyle(
                                      fontSize: MediaWidth / 22,
                                      color: Colors.black45)),
                              Text(
                                ' ${widget.codReferencia}',
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
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                        bottom: BorderSide( //                   <--- left side
                        color: Colors.black38,
                        width: 1.0,
                        ),
                      ),
                     ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              children: [
                                Text('Tabela preço:',
                                    style: TextStyle(
                                        fontSize: MediaWidth / 22,
                                        color: Colors.black45,
                                    ),
                                ),
                                DropdownButton<String>(
                                  icon: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: const Icon(
                                      Icons.arrow_drop_down_circle_outlined,
                                      size: 20,
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
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Center(
                                            child: Text(
                                          item,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: MediaWidth / 22,
                                          ),
                                        )),
                                      );
                                    }).toList();
                                  },
                                  items: widget.nomesTabelaDePreco.map((String item) {
                                    return DropdownMenuItem<String>(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '$item',
                                                style: TextStyle(
                                                    fontSize: MediaWidth / 22,
                                                    fontWeight: FontWeight.normal,
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
                              ],
                            ),
                          ),
                        ],
                      ),
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
