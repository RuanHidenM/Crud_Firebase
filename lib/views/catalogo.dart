import 'dart:io' as Io;
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/complements/selectfirebase.dart';
import 'package:crud_firebase/components/mytextfield.dart';
import 'package:crud_firebase/models/produto/familia.dart';
import 'package:crud_firebase/models/produto/tabeladepreco.dart';
import 'package:crud_firebase/views/detalhesdoitem.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Catalogo extends StatefulWidget {
  @override
  _catalogo createState() => _catalogo();
}

class _catalogo extends State<Catalogo> {
  static String tag = '/catalogo';
  get MediaWdth => MediaQuery.of(context).size.width;
  var userLogado = FirebaseAuth.instance.currentUser;
  var snapshots;
  var empresasJson;
  var CNPJDaEmpresaLogada = '';
  var varValordoProduto;
  final _nomeProdutoFiltro = TextEditingController();

  @override
  void initState(){
    super.initState();
    _nomeProdutoFiltro;
  }

  Future <List<String>> BuscandoProdutosDaEmpresa() async {
    await BuscandoCNPJdaEmpresaLogada().then((value) => setState(() {
      CNPJDaEmpresaLogada = value;
    }));

    snapshots = await FirebaseFirestore.instance
        .collection('Tenant')
        .doc('4c0356cd-c4f7-4901-b247-63e400d56085')
        .collection('Empresas')
        .doc(CNPJDaEmpresaLogada.toString())
        .collection('Produtos').snapshots();
    return snapshots;
  }

  _catalogo() {
    BuscandoProdutosDaEmpresa().then((value) => setState((){
      snapshots = value;
    }));
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    print(_nomeProdutoFiltro.text);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //drawer:DrawerSide(),
      appBar: AppBar(
        shadowColor: Color.fromRGBO(36, 82, 108, 250),
        //Todo: cor da borda shadow, para ficar mesclado com o widget de filtro a baixo
        backgroundColor: Color.fromRGBO(36, 82, 108, 25),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Catálogo',
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(Icons.filter_list_rounded,
                  color: Colors.white, size: 25),
            ),
          ],
        ),

        // Text('Produtos', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  color: Color.fromRGBO(36, 82, 108, 25),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      //TODO: SAFE
                      Expanded(
                        flex: 3,
                        child: Container(
                          //color:Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 250,
                                      height: 55,
                                      child: myTextField(
                                        titleName: 'Buscar Produtos',
                                        descriptionName: '',
                                        tamanhodoEdgeInsert: const EdgeInsets.all(1.0),
                                        tamanhoDasLetrasImput: const TextStyle(fontSize: 14),
                                        nomeDoComtrolador: _nomeProdutoFiltro
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.qr_code_scanner,
                                  color: Colors.white,
                                  size: 25,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
          ),
          Expanded(
            flex: 9,
            child: StreamBuilder(
              stream: snapshots,
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting || snapshots == null) {
                  return Center(child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
                  ));
                }
                if (snapshot.data.docs.length == 0) {
                  return Center(child: Text('Nenhum Produto Cadastrado!'));
                } ;
                //TODO: Lista dos usuarios cadastrados.
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {//TODO: Busca apenas tabela de preco que for marcado com sim
                      var produtos = snapshot.data.docs[i];
                      var tabelaDePrecoPadrao = produtos['TABELASDEPRECO'].where((element) =>
                          element['Padrao'] == 'S',
                      );

                      var nomeTabeladePrecoQueForSim;
                      final List<String> tabelaDePreco = List();  //TODO: Defini em um modelo 'TabelaDePreco', a tabela que foi buscado como sim.
                      for(Map<String, dynamic> element in tabelaDePrecoPadrao){
                        final TabelaDePreco tabeladepreco = TabelaDePreco(
                          element['Preco'],
                          element['Padrao'],
                          element['Nome'],
                        );
                        tabelaDePreco.add(tabeladepreco.Preco.toStringAsFixed(2));
                        nomeTabeladePrecoQueForSim = '${tabeladepreco.Nome}: R\$ ${tabeladepreco.Preco.toStringAsFixed(2).replaceAll('.', ',')}';
                      }
                      var valorDoProdutoQueForSim = tabelaDePreco.toString().replaceAll('[', '').replaceAll(']', '');

                      final List<String> NomestabelaDePreco = List();//Todo: Nomes das tabelas de Preco.
                      for(Map<String, dynamic> element in produtos['TABELASDEPRECO']){
                        final TabelaDePreco tabeladepreco = TabelaDePreco(
                          element['Preco'],
                          element['Padrao'],
                          element['Nome'],
                        );
                        NomestabelaDePreco.add('${tabeladepreco.Nome}: R\$ ${tabeladepreco.Preco.toStringAsFixed(2).replaceAll('.', ',')}');
                       // print('Formatação: ${tabeladepreco.Preco.toString()}');
                      }
                      //TODO: BASE64 IMG
                      // print('img base64 String: ${produtos['IMAGEM'][0]['Imagem']}');
                      // final decodedBytes = base64Decode(produtos['IMAGEM'][0]['Imagem'].toString());
                      // print('Bytes: $decodedBytes');
                      // var file = Io.File("decodedBytes.png");
                      // print('File: ${file}');

                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
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
                                          child: Container(
                                            height: 100,
                                            //color: Colors.yellow,
                                            child: Center(
                                              child: ClipRRect(
                                                child:
                                                    produtos['NOME'] == 'CAPAC. ELET. IMPORT. -  1.000 MF  X   16 V - RADIAL' ?
                                                    Image.asset('cap.png'):
                                                    produtos['NOME'] == 'COMPUTADOR LIVA ZE INTEL WINDOWS ULN3350430W DUAL CORE N3350 4GB SSD 30GB HDMI USB REDE WINDOWS 10' ?
                                                    Image.asset('comp-live.png'):
                                                    produtos['NOME'] == 'NOTEBOOK LENOVO B330-15IKBR INTEL CORE I3 7020U 4GB SSD 240GB 15.6 WINDOWS 10 HOME PRETO' ?
                                                    Image.asset('note-lenovo.png'):
                                                    produtos['NOME'] == 'NOTE ACER A315 I3 15.6 8GB SSD 240GB  W10' ?
                                                    Image.asset('note-acer.png') :
                                                    Icon(
                                                      Icons.image_outlined,
                                                      //Icons.image_not_supported_outlined,
                                                      color: Colors.black12,
                                                      size: MediaWdth / 8,
                                                    ),
                                                // TODO: Se a não tiver img, esse icon ser mostrado.
                                              ),
                                            ),
                                          )),
                                      Expanded(
                                          flex: 7,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                    height: MediaQuery.of(context).size.height/ 11,
                                                   // color:Colors.red,
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
                                                            Text('${valorDoProdutoQueForSim.replaceAll('.', ',')}', style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.height/ 45),),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetalhesDoItem(
                            nome: produtos['NOME'],
                            descricao: produtos['NOME'],
                            un: produtos['ESTOQUE'],
                            valor: valorDoProdutoQueForSim,
                            nomeFamilia:produtos['FAMILIA']['Nome'],
                            codReferencia:produtos['REFERENCIA'],
                            codDoProduto: produtos['CODIGO'],
                            codNCM: produtos['NCM'],
                            nomesTabelaDePreco: NomestabelaDePreco,
                            nomeTabeladePrecoQueForSim: nomeTabeladePrecoQueForSim,
                            unidadeDeMedida : produtos['UNIDADEDEMEDIDA']['Nome'],
                            custoLiquido: produtos['CUSTOLIQUIDO'],
                            cadastroData: produtos['CADASTRODATA'],
                          )));
                        },
                      );
                    });
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => CreateUserPage(
      //                 tipo:
      //                 'create'))); //TODO: Navegando para a tela de criar usuario.
      //   },
      //   tooltip: 'Adicionar um novo usuario.',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
