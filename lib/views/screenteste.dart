
import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/complements/convertereais.dart';
import 'package:crud_firebase/complements/selectfirebase.dart';
import 'package:crud_firebase/components/progress.dart';
import 'package:crud_firebase/models/produto/tabeladepreco.dart';
import 'package:crud_firebase/views/drawerside.dart';
import 'package:crud_firebase/views/screen_erro_login.dart';
import 'package:crud_firebase/views/screen_mestre_loadding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:paginate_firestore/paginate_firestore.dart';

class ScreenTeste extends StatefulWidget{
  _creenTeste createState() => _creenTeste();
}

class  _creenTeste extends State<ScreenTeste>{
  get MediaWidth => MediaQuery.of(context).size.width;
  var snapshotsProdutos;
  var CNPJDaEmpresaLogada;

  _creenTeste() {
    buscandoCaixaEBancoDaEmpresa().then((value) => setState((){
      snapshotsProdutos = value;
    }));
  }

  Future<List<String>> buscandoCaixaEBancoDaEmpresa() async {
    await buscandoCNPJdaEmpresaLogada().then((value) => setState(() {
      CNPJDaEmpresaLogada = value;
    }));
    await buscandoTenantIdDoUsuarioLogado().then((value) => setState(() {
      tenanteIDDoUsuarioLogado = value;
    }));
    snapshotsProdutos = await FirebaseFirestore.instance
        .collection('Tenant')
        .doc(tenanteIDDoUsuarioLogado.toString())
        .collection('Empresas')
        .doc(CNPJDaEmpresaLogada.toString())
        .collection('Produtos')
        .orderBy('ESTOQUE', descending: true).limit(5)
        .snapshots();
    return snapshotsProdutos;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Teste'),
      ),
      body: Container(
        child: snapshotsProdutos == null ? Progress() : StreamBuilder(
          stream: snapshotsProdutos,
          builder:(
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshotsProdutos,
          ){

          return PaginateFirestore(
            shrinkWrap: false,
            itemsPerPage: 10,
            itemBuilder: (index, context, snapshotsProdutos ) {
              final produtos = snapshotsProdutos; 
              var tabelaDePrecoPadrao = produtos['TABELASDEPRECO'].where((element) =>
                  element['Padrao'] == 'S',
              );
              var nomeTabeladePrecoQueForSim;
              //TODO: Defini no modelo 'TabelaDePreco', a tabela que foi buscada como 'SIM'
              final List<String> tabelaDePreco = List();
              for(Map<String, dynamic> element in tabelaDePrecoPadrao){
                final TabelaDePreco tabeladepreco = TabelaDePreco(
                  element['Preco'],
                  element['Padrao'],
                  element['Nome']
                );
                tabelaDePreco.add(tabeladepreco.preco.toStringAsFixed(2));
                nomeTabeladePrecoQueForSim = '${tabeladepreco.nome}: R\$ ${converteReais(tabeladepreco.preco)}';
              }
              //TODO: SE NÃO TIVER NENHUMA TABELA SELECIONADA
              nomeTabeladePrecoQueForSim == null
                  ? nomeTabeladePrecoQueForSim = 'Tabela não selecionada'
                  : nomeTabeladePrecoQueForSim;

              var valorDoProdutoQueForSim;
              valorDoProdutoQueForSim = tabelaDePreco.toString().replaceAll('[', '').replaceAll(']', '');//TODO REMOVENDO AS []
              valorDoProdutoQueForSim == '' ? valorDoProdutoQueForSim = '0.00' : valorDoProdutoQueForSim;//TODO SE NÃO TIVER VALOR, ADICIONAR 0

              //Todo: Nomes das tabelas de Preco.
              final List<String> NomestabelaDePreco = List();
              for(Map<String, dynamic> element in produtos['TABELASDEPRECO']){
                final TabelaDePreco tabeladepreco = TabelaDePreco(
                  element['Preco'],
                  element['Padrao'],
                  element['Nome']
                );
                NomestabelaDePreco.add('${tabeladepreco.nome}: R\$ ${converteReais(tabeladepreco.preco)}');
              }

              Uint8List bytesImg = base64Decode(produtos['IMAGEM'].toString().replaceAll('[','').replaceAll(']', ''));

              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
                  child: Container(
                    height: MediaWidth / 3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: const Offset(
                            1.0,
                            1.0,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child:
                                bytesImg.toString() != '[]'
                                    ?
                                Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: MemoryImage(bytesImg),
                                        )
                                    )
                                )
                                    :
                                Icon(
                                  Icons.image_not_supported_outlined,
                                  //Icons.image_not_supported_outlined,
                                  color: Colors.black12,
                                  size: MediaWidth / 5,
                                ),

                              ),
                              Expanded(
                                flex: 7,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context).size.height/ 11,
                                          //color:Colors.red,
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom:9.0),
                                              child: Text(
                                                '${produtos['NOME']}',
                                                overflow: TextOverflow.fade,
                                                // overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: MediaQuery.of(context).size.height/ 48,
                                                ),
                                              ),
                                            ),
                                          )
                                      ),
                                      Container(
                                        //color:Colors.blue,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 5),
                                                    child: Icon(Icons.monetization_on, color: Colors.green, size: MediaQuery.of(context).size.height/ 40,),
                                                  ),
                                                  Text('R\$: ', style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.height/ 50),),
                                                  Text('${converteReais(valorDoProdutoQueForSim)}', style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.height/ 45),),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right: 5),
                                                    child: Icon(Icons.widgets, color: Color.fromRGBO(36, 82, 108, 60), size: MediaQuery.of(context).size.height/ 44,),
                                                  ),
                                                  Text('Estoque: ', style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.height/ 50),),
                                                  Text('${produtos['ESTOQUE'].round()}',
                                                    style: TextStyle(
                                                        color: Colors.black54
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
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
                  ),
                ),
                onDoubleTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => DetalhesDoItem(
                  //   imgProduto: bytesImg,
                  //   nome: produtos['NOME'],
                  //   descricao: produtos['NOME'],
                  //   un: produtos['ESTOQUE'],
                  //   valor: valorDoProdutoQueForSim,
                  //   nomeFamilia:produtos['FAMILIA']['Nome'],
                  //   codReferencia:produtos['REFERENCIA'],
                  //   codDoProduto: produtos['CODIGO'],
                  //   codNCM: produtos['NCM'],
                  //   nomesTabelaDePreco: NomestabelaDePreco,
                  //   nomeTabeladePrecoQueForSim: nomeTabeladePrecoQueForSim,
                  //   unidadeDeMedida : produtos['UNIDADEDEMEDIDA']['Nome'],
                  //   custoLiquido: produtos['CUSTOLIQUIDO'],
                  //   cadastroData: produtos['CADASTRODATA'],
                  // )));
                },
              );
            },
            // orderBy is compulsory to enable pagination
            query: FirebaseFirestore.instance
              .collection('Tenant')
              .doc('fc61a75d-3d37-43e6-bac5-412c2c374991')
              .collection('Empresas')
              .doc('85262988000110')
              .collection('Produtos')
              .orderBy('ESTOQUE', descending: true),
            //Change types accordingly
            itemBuilderType: PaginateBuilderType.listView,
            // to fetch real-time data
            isLive: true,
          );
          }
        )
      ),
    );
  }
}
