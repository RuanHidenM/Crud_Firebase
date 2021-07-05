import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/complements/convertereais.dart';
import 'package:crud_firebase/complements/selectfirebase.dart';
import 'package:crud_firebase/components/mytextfield.dart';
import 'package:crud_firebase/components/progress.dart';
import 'package:crud_firebase/models/produto/tabeladepreco.dart';
import 'package:crud_firebase/views/detalhesdoitem.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

import 'package:paginate_firestore/paginate_firestore.dart';

class Catalogo extends StatefulWidget {
  @override
  _catalogo createState() => _catalogo();
}

class _catalogo extends State<Catalogo> {
  get MediaWidth => MediaQuery.of(context).size.width;
  var userLogado = FirebaseAuth.instance.currentUser;
  var snapshots;
  var tenanteIDDoUsuarioLogado;
  var empresasJson;
  var CNPJDaEmpresaLogada = '';
  var varValordoProduto;
  final _nomeProdutoFiltro = TextEditingController();

  @override
  void initState(){
    super.initState();
    _nomeProdutoFiltro;
  }

  _catalogo() {
    BuscandoProdutosDaEmpresa().then((value) => setState((){
      snapshots = value;
    }));

    // BuscandoTenantIdDoUsuarioLogado().then((value) => setState((){
    //   tenanteIDDoUsuarioLogado = value;
    // }));
  }


  Future <List<String>> BuscandoProdutosDaEmpresa() async {

    await buscandoTenantIdDoUsuarioLogado().then((value) => tenanteIDDoUsuarioLogado = value);
    await buscandoCNPJdaEmpresaLogada().then((value) => setState(() {
      CNPJDaEmpresaLogada = value;
    }));

    snapshots = await FirebaseFirestore.instance
        .collection('Tenant')
        .doc(tenanteIDDoUsuarioLogado.toString())
        .collection('Empresas')
        .doc(CNPJDaEmpresaLogada.toString())
        .collection('Produtos')
        .orderBy('ESTOQUE', descending: true).where('ESTOQUE', isEqualTo: 1)
        .snapshots();
    return snapshots;
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(Icons.filter_list_rounded,
                    color: Colors.white, size: 25),
              ),
              onTap: (){

              },
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
                        flex: 4,
                        child: Container(
                          //color:Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 20, bottom: 5),
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
              child: snapshots == null
                  ? Progress()
                  : StreamBuilder(
                  stream: snapshots,
                  builder:(
                      BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot,
                    ){
                    return PaginateFirestore(

                      shrinkWrap: false,
                      itemsPerPage: 10,
                        //header: SliverToBoxAdapter(child: Text('HEADER')),
                        //footer: SliverToBoxAdapter(child: Text('FOOTER')),
                      //TODO: BLOCO LOADDING MAIS PRODUTOS
                      bottomLoader: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CircularProgressIndicator(
                                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
                                    strokeWidth: 2,
                                  ),
                                  Text('Carregando mais produtos...',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: MediaWidth / 25,
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // item builder type is compulsory.
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


                        double estoqueDoProduto;
                        if(produtos['ESTOQUE'].runtimeType == int){
                          estoqueDoProduto = produtos['ESTOQUE'].toDouble();
                        }else{
                          estoqueDoProduto = produtos['ESTOQUE'];
                        }

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
                                                            Text('$estoqueDoProduto',
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
                              imgProduto: bytesImg,
                              nome: produtos['NOME'],
                              descricao: produtos['NOME'],
                              un: estoqueDoProduto,
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
                              grupo: produtos['GRUPO']['Nome'],
                              subGrupo: produtos['SUBGRUPO']['Nome'],
                              marca:produtos['MARCA']['Nome']
                            )));
                          },
                        );
                      },
                      // orderBy is compulsory to enable pagination
                      query: FirebaseFirestore.instance
                          .collection('Tenant')
                          .doc(tenanteIDDoUsuarioLogado)
                          .collection('Empresas')
                          .doc(CNPJDaEmpresaLogada)
                          .collection('Produtos'),
                      //Change types accordingly
                      itemBuilderType: PaginateBuilderType.listView,
                      // to fetch real-time data
                      isLive: true,
                    );
                  }
              )
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
