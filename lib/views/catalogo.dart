import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/complements/convertereais.dart';
import 'package:crud_firebase/complements/selectfirebase.dart';
import 'package:crud_firebase/components/botton_title_icon_tipo_filtro_caixaebanco.dart';
import 'package:crud_firebase/components/mytextfield.dart';
import 'package:crud_firebase/components/progress.dart';
import 'package:crud_firebase/models/produto/tabeladepreco.dart';
import 'package:crud_firebase/views/detalhesdoitem.dart';
import 'package:crud_firebase/views/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'dart:typed_data';

import 'package:paginate_firestore/paginate_firestore.dart';

import '../globals.dart';
import 'drawersidefiltrosdocatalogo.dart';

class Catalogo extends StatefulWidget {
  @override
  _catalogo createState() => _catalogo();
}

class _catalogo extends State<Catalogo> {
  get MediaWidth => MediaQuery.of(context).size.width;
  var userLogado = FirebaseAuth.instance.currentUser;
  var snapshots;
  var nomeDasFamilas;
  var snapshotsOrde;
  var tenanteIDDoUsuarioLogado;
  var empresasJson;
  var CNPJDaEmpresaLogada = '';
  var varValordoProduto;
  final _nomeProdutoFiltro = TextEditingController();

  // String dropdownValueFamilia = 'Selecione uma Familia';
  // String dropdownValueGrupo = 'Selecione um Grupo';
  // String dropdownValueMarca = 'Selecione uma Marca';

  //Todo: relacionado ao refresh da tela sobre o filtro
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  @override
  void initState() {
    super.initState();
    _nomeProdutoFiltro;
    filtroCatalogoOrdenarEstoque;
  }

  _catalogo() {
    //TODO: Buscando todos os produtos da empresa
    BuscandoProdutosDaEmpresa().then((value) => setState(() {
          snapshots = value;
    }));
    //TODO: Buscando todas as familias.
    buscandoTodasAsFamilias().then((value) => setState((){
      nomeDasFamilas = value;
      print('nome das familias: $nomeDasFamilas');
    }));
    //TODO: Buscando todos os grupos.
    //TODO: Buscando todos os subgrupos.
    //TODO: Buscando todas as marcas

    // BuscandoProdutosDaEmpresaFiltroValorOrdemCrecente().then((value) => setState(() {
    //       snapshotsOrde = value;
    // }));

    // BuscandoTenantIdDoUsuarioLogado().then((value) => setState((){
    //   tenanteIDDoUsuarioLogado = value;
    // }));
  }

  //todo select1
  Future<List<String>> BuscandoProdutosDaEmpresa() async {
    //TODO: PEGANDO OS DADOS APENAS DO CACHE
    //await FirebaseFirestore.instance.disableNetwork();
    await buscandoTenantIdDoUsuarioLogado()
        .then((value) => tenanteIDDoUsuarioLogado = value);
    await buscandoCNPJdaEmpresaLogada().then((value) => setState(() {
          CNPJDaEmpresaLogada = value;
        }));

    snapshots = await FirebaseFirestore.instance
        .collection('Tenant')
        .doc(tenanteIDDoUsuarioLogado)
        .collection('Empresas')
        .doc(CNPJDaEmpresaLogada)
        .collection('Produtos')
        .limit(30)
        .snapshots();
    //TODO POR MAIOR, DESENDENTE
    return snapshots;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawerEdgeDragWidth: MediaWidth / 3,
      drawerScrimColor: Colors.black26,
      endDrawer: Container(
        width: MediaWidth / 1.45,
        child: Drawer(
          child: ListView(

            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: MediaWidth / 2.5,
                child: DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.filter_alt_outlined,
                            color: Colors.white70,
                            size: MediaWidth / 16,
                          ),
                          Text(
                            'Filtro Catalogo',
                            style: TextStyle(
                                color: Colors.white, fontSize: MediaWidth / 20),
                          ),
                        ],
                      ),
                      Text(
                        'Selecione uma das opções para efetuar o filtro no catalogo.',
                        style: TextStyle(
                            color: Colors.white70, fontSize: MediaWidth / 29),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topCenter,
                      colors: [
                        Color.fromRGBO(36, 82, 108, 1),
                        //TODO Azul 4/4
                        Color.fromRGBO(36, 82, 108, 15),
                        //TODO AZUL 3/4. BRANCO 1/4
                        Color.fromRGBO(36, 82, 108, 30),
                        //TODO AZUL 2/4, BRANCO 2/4
                        Color.fromRGBO(36, 82, 108, 45),
                        //TODO AZUL 1/4, BRANCO 3/4
                        Color.fromRGBO(36, 82, 108, 50),
                        //TODO BRANCO 4/4
                      ],
                    ),
                  ),
                ),
              ),  //TODO: Top bar da barra lateral filtro
               Container(
                    color: Color.fromARGB(100, 234, 234, 234),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 0.1,
                                color: Colors.black54
                            ),
                          )
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Icon(Icons.art_track,
                                  size: MediaWidth / 12,
                                  color: Colors.black54,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Ordenar Catalogo',
                                style: TextStyle(
                                    fontSize: MediaWidth / 21,
                                    color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 10),
                                    child: filtroCatalogoOrdenarEstoque == true
                                        ? Icon(Icons.filter_list_rounded,
                                            color: Colors.black54,
                                            size: MediaWidth / 13)
                                        : Transform.rotate(
                                            angle: 180 * pi / 180,
                                            child: Icon(Icons.filter_list_rounded,
                                                color: Colors.black54,
                                                size: MediaWidth / 13),
                                          )),
                                Text(
                                  filtroCatalogoOrdenarEstoque == true
                                      ? 'Maior Estoque'
                                      : 'Menor Estoque',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: MediaWidth / 25),
                                ),
                              ],
                            ),
                            onTap: () {
                              if(filtroCatalogoOrdenarEstoque == true){
                                setState(() {
                                  filtroCatalogoOrdenarEstoque = false;
                                });
                              }else{
                                setState(() {
                                  filtroCatalogoOrdenarEstoque = true;
                                  _catalogo();
                                });
                              }
                              Timer(Duration(milliseconds: 250), () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Catalogo()));
                              });
                            },
                          ),
                          GestureDetector(
                            child: Row(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 10),
                                    child: filtroCatalogoOrdenarValor == true
                                        ? Icon(Icons.filter_list_rounded,
                                            color: Colors.black54,
                                            size: MediaWidth / 13)
                                        : Transform.rotate(
                                            angle: 180 * pi / 180,
                                            child: Icon(Icons.filter_list_rounded,
                                                color: Colors.black54,
                                                size: MediaWidth / 13),
                                          )),
                                Text(
                                  filtroCatalogoOrdenarValor == true
                                      ? 'Maior Valor'
                                      : 'Menor Valor**',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: MediaWidth / 25),
                                ),
                              ],
                            ),
                              onTap: () {
                                if(filtroCatalogoOrdenarValor == true){
                                  setState(() {
                                    filtroCatalogoOrdenarValor = false;
                                  });
                                }else{
                                  setState(() {
                                    filtroCatalogoOrdenarValor = true;
                                    _catalogo();
                                  });
                                }
                              Timer(Duration(milliseconds: 250), () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => Catalogo()));
                              });
                              },
                          ),
                        ],
                      ),
                    )

                    // ListTile(
                    //   title: Container(
                    //     child: Row(
                    //       children: [
                    //         Padding(
                    //             padding: const EdgeInsets.only(left: 0, right: 10),
                    //             child:
                    //             filtroCatalogoOrdenar == true ?
                    //             Icon(Icons.filter_list_rounded, color: Colors.black54, size: MediaWidth / 13)
                    //                 :
                    //             Transform.rotate(
                    //               angle: 180 * pi / 180,
                    //               child:  Icon(Icons.filter_list_rounded, color: Colors.black54, size: MediaWidth / 13),
                    //             )
                    //         ),
                    //         Text(
                    //           filtroCatalogoOrdenar == true
                    //           ?
                    //           'Ordenando maior Estoque'
                    //           :
                    //           'Ordenando menor Estoque',
                    //           style: TextStyle(
                    //               color: Colors.black54,
                    //               fontSize: MediaWidth / 25
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     if(filtroCatalogoOrdenar == true){
                    //       setState(() {
                    //         filtroCatalogoOrdenar = false;
                    //       });
                    //     }else{
                    //       setState(() {
                    //         filtroCatalogoOrdenar = true;
                    //         _catalogo();
                    //       });
                    //     }
                    //   Timer(Duration(milliseconds: 250), () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => Catalogo()));
                    //   });
                    //   },
                    // ),

                    ), //TODO: Filtro por Ordenar Catalogo

                Padding(
                  padding: const EdgeInsets.only(top:5),
                  child: Container(
                    color: Color.fromARGB(100, 234, 234, 234),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title:  Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Icon(Icons.auto_awesome_motion,
                              size: MediaWidth / 17,
                              color: dropdownValueFamilia == 'Selecione uma Familia' ? Colors.black54 : Colors.orange,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Familia',
                              style: TextStyle(
                                  fontSize: MediaWidth / 21,
                                  color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      subtitle:
                      Container(
                          width: double.infinity,
                          child: Center(
                            child: DropdownButton<String>(
                              value: dropdownValueFamilia,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black54,
                                fontSize: 18
                              ),
                              underline: Container(
                                height: 0,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValueFamilia = newValue;
                                });
                              },
                              items: <String>['Selecione uma Familia','One', 'Two', 'Free', 'Four']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                  ),
              ),
                ),//TODO: Filtro por Familia
                Padding(
                  padding: const EdgeInsets.only(top:5),
                  child: Container(
                    color: Color.fromARGB(100, 234, 234, 234),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title:  Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Icon(Icons.auto_awesome_motion,
                              size: MediaWidth / 17,
                              color: dropdownValueGrupo == 'Selecione um Grupo' ? Colors.black54 : Colors.orange,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Grupo**',
                              style: TextStyle(
                                  fontSize: MediaWidth / 21,
                                  color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      subtitle:
                      Container(
                          width: double.infinity,
                          child: Center(
                            child: DropdownButton<String>(
                              value: dropdownValueGrupo,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black54,
                                fontSize: 18
                              ),
                              underline: Container(
                                height: 0,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValueGrupo = newValue;
                                });
                              },
                              items: <String>['Selecione um Grupo','One', 'Two', 'Free', 'Four']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                  ),
              ),
                ),
              Padding(
                  padding: const EdgeInsets.only(top:5),
                  child: Container(
                    color: Color.fromARGB(100, 234, 234, 234),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title:  Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Icon(Icons.auto_awesome_motion,
                              size: MediaWidth / 17,
                              color: dropdownValueSubGrupo == 'Selecione um SubGrupo' ? Colors.black54 : Colors.orange,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'SubGrupo**',
                              style: TextStyle(
                                  fontSize: MediaWidth / 21,
                                  color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      subtitle:
                      Container(
                          width: double.infinity,
                          child: Center(
                            child: DropdownButton<String>(
                              value: dropdownValueSubGrupo,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black54,
                                fontSize: 18
                              ),
                              underline: Container(
                                height: 0,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValueSubGrupo = newValue;
                                });
                              },
                              items: <String>['Selecione um SubGrupo','One', 'Two', 'Free', 'Four']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                  onTap: (){
                                    print('---------------select $value');
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                  ),
              ),
                ),//TODO: Filtro por Grupo
                Padding(
                  padding: const EdgeInsets.only(top:5),
                  child: Container(
                    color: Color.fromARGB(100, 234, 234, 234),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title:  Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Icon(Icons.auto_awesome_motion,
                              size: MediaWidth / 17,
                              color: dropdownValueMarca == 'Selecione uma Marca' ? Colors.black54 : Colors.orange,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              'Marca**',
                              style: TextStyle(
                                  fontSize: MediaWidth / 21,
                                  color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      subtitle:
                      Container(
                          width: double.infinity,
                          child: Center(
                            child: DropdownButton<String>(
                              value: dropdownValueMarca,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black54,
                                fontSize: 18
                              ),
                              underline: Container(
                                height: 0,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValueMarca = newValue;
                                });
                              },
                              items: <String>['Selecione uma Marca','One', 'Two', 'Free', 'Four']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                  ),
              ),
                ) //TODO: Filtro por Marca
            ],
          ),
        ),
      ),
      appBar: AppBar(
        //TODO: Botão de returno
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage())),
        ),

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
                        padding: const EdgeInsets.only(
                            left: 15, right: 20, bottom: 5),
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
                                      tamanhodoEdgeInsert:
                                          const EdgeInsets.all(1.0),
                                      tamanhoDasLetrasImput:
                                          const TextStyle(fontSize: 14),
                                      nomeDoComtrolador: _nomeProdutoFiltro),
                                ),
                              ],
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.qr_code_scanner,
                                color: Colors.white,
                                size: 25,
                              ),
                              onTap: () {
                                refreshChangeListener.refreshed = true;
                              },
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
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot,
                    ) {
                      return RefreshIndicator(
                        strokeWidth: 2,
                        color: Colors.orange,
                        onRefresh: () async {
                          refreshChangeListener.refreshed =
                              true; //Todo Atualiza o a lista
                          setState(() {
                            filtroCatalogoOrdenarEstoque;
                          });
                        },
                        child: PaginateFirestore(
                          shrinkWrap: false,
                          itemsPerPage: 20,
                          //footer: SliverToBoxAdapter(child: Text('FOOTER')),
                          header: SliverToBoxAdapter(
                          //
                          ),
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
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.orange),
                                        strokeWidth: 2,
                                      ),
                                      Text(
                                        'Carregando mais produtos...',
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: MediaWidth / 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // item builder type is compulsory.
                          itemBuilder: (index, context, snapshotsProdutos) {
                            final produtos = snapshotsProdutos;

                            var tabelaDePrecoPadrao =
                                produtos['TABELASDEPRECO'].where(
                              (element) => element['Padrao'] == 'S',
                            );

                            var nomeTabeladePrecoQueForSim;
                            //TODO: Defini no modelo 'TabelaDePreco', a tabela que foi buscada como 'SIM'
                            final List<String> tabelaDePreco = List();
                            for (Map<String, dynamic> element
                                in tabelaDePrecoPadrao) {
                              final TabelaDePreco tabeladepreco = TabelaDePreco(
                                  element['Preco'],
                                  element['Padrao'],
                                  element['Nome']);
                              tabelaDePreco
                                  .add(tabeladepreco.preco.toStringAsFixed(2));
                              nomeTabeladePrecoQueForSim =
                                  '${tabeladepreco.nome}: R\$ ${converteReais(tabeladepreco.preco)}';
                            }
                            //TODO: SE NÃO TIVER NENHUMA TABELA SELECIONADA
                            nomeTabeladePrecoQueForSim == null
                                ? nomeTabeladePrecoQueForSim =
                                    'Tabela não selecionada'
                                : nomeTabeladePrecoQueForSim;

                            var valorDoProdutoQueForSim;
                            valorDoProdutoQueForSim = tabelaDePreco
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', ''); //TODO REMOVENDO AS []
                            valorDoProdutoQueForSim == ''
                                ? valorDoProdutoQueForSim = '0.00'
                                : valorDoProdutoQueForSim; //TODO SE NÃO TIVER VALOR, ADICIONAR 0

                            double estoqueDoProduto;
                            if (produtos['ESTOQUE'].runtimeType == int) {
                              estoqueDoProduto = produtos['ESTOQUE'].toDouble();
                            } else {
                              estoqueDoProduto = produtos['ESTOQUE'];
                            }

                            //Todo: Nomes das tabelas de Preco.
                            final List<String> NomestabelaDePreco = List();
                            for (Map<String, dynamic> element
                                in produtos['TABELASDEPRECO']) {
                              final TabelaDePreco tabeladepreco = TabelaDePreco(
                                  element['Preco'],
                                  element['Padrao'],
                                  element['Nome']);
                              NomestabelaDePreco.add(
                                  '${tabeladepreco.nome}: R\$ ${converteReais(tabeladepreco.preco)}');
                            }
                            Uint8List bytesImg = base64Decode(produtos['IMAGEM']
                                .toString()
                                .replaceAll('[', '')
                                .replaceAll(']', ''));

                            return GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, bottom: 5, right: 5, left: 5),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: bytesImg.toString() != '[]'
                                                  ? Container(
                                                      height: MediaWidth / 3.5,
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                        image: MemoryImage(
                                                            bytesImg),
                                                      )))
                                                  : Icon(
                                                      Icons
                                                          .image_not_supported_outlined,
                                                      //Icons.image_not_supported_outlined,
                                                      color: Colors.black12,
                                                      size: MediaWidth / 5,
                                                    ),
                                            ),
                                            Expanded(
                                              flex: 7,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5,
                                                    bottom: 5,
                                                    left: 5,
                                                    right: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            11,
                                                        //color:Colors.red,
                                                        child: Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        9.0),
                                                            child: Text(
                                                              '${produtos['NOME']}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              // overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    48,
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                    Container(
                                                        //color:Colors.blue,
                                                        child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 5),
                                                              child: Icon(
                                                                Icons
                                                                    .monetization_on,
                                                                color: Colors
                                                                    .green,
                                                                size: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    40,
                                                              ),
                                                            ),
                                                            Text(
                                                              'R\$: ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      50),
                                                            ),
                                                            Text(
                                                              '${converteReais(valorDoProdutoQueForSim)}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      45),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right: 5),
                                                              child: Icon(
                                                                Icons.widgets,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        36,
                                                                        82,
                                                                        108,
                                                                        60),
                                                                size: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    44,
                                                              ),
                                                            ),
                                                            // Text(
                                                            //   'Estoque: ',
                                                            //   style: TextStyle(
                                                            //       color: Colors
                                                            //           .grey,
                                                            //       fontSize: MediaQuery.of(
                                                            //                   context)
                                                            //               .size
                                                            //               .height /
                                                            //           50),
                                                            // ),
                                                            Text(
                                                              '$estoqueDoProduto',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            Text('- $index'),
                                                          ],
                                                        ),
                                                      ],
                                                    )),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetalhesDoItem(
                                            imgProduto: bytesImg,
                                            nome: produtos['NOME'],
                                            descricao: produtos['NOME'],
                                            un: estoqueDoProduto,
                                            valor: valorDoProdutoQueForSim,
                                            nomeFamilia: produtos['FAMILIA']
                                                ['Nome'],
                                            codReferencia:
                                                produtos['REFERENCIA'],
                                            codDoProduto: produtos['CODIGO'],
                                            codNCM: produtos['NCM'],
                                            nomesTabelaDePreco:
                                                NomestabelaDePreco,
                                            nomeTabeladePrecoQueForSim:
                                                nomeTabeladePrecoQueForSim,
                                            unidadeDeMedida:
                                                produtos['UNIDADEDEMEDIDA']
                                                    ['Nome'],
                                            custoLiquido:
                                                produtos['CUSTOLIQUIDO'],
                                            cadastroData:
                                                produtos['CADASTRODATA'],
                                            grupo: produtos['GRUPO']['Nome'],
                                            subGrupo: produtos['SUBGRUPO']
                                                ['Nome'],
                                            marca: produtos['MARCA']['Nome'])));
                              },
                            );
                          },
                          // orderBy is compulsory to enable pagination
                          query: filtroCatalogoOrdenarEstoque == true
                              ? FirebaseFirestore.instance
                                  .collection('Tenant')
                                  .doc(tenanteIDDoUsuarioLogado)
                                  .collection('Empresas')
                                  .doc(CNPJDaEmpresaLogada)
                                  .collection('Produtos')
                                  .orderBy('ESTOQUE', descending: true)
                                  .limit(30)

                              : FirebaseFirestore.instance
                                  .collection('Tenant')
                                  .doc(tenanteIDDoUsuarioLogado)
                                  .collection('Empresas')
                                  .doc(CNPJDaEmpresaLogada)
                                  .collection('Produtos')
                                  .orderBy('ESTOQUE', descending: false)
                                  ///.where('ESTOQUE', isLessThanOrEqualTo: 1)
                                  .limit(30),

                          /*
                          *
                         *    var tabelaDePrecoPadrao =  produtos['TABELASDEPRECO'].where(
                              (element) => element['Padrao'] == 'S',
                            );
                          *
                          * */

                          initialLoader:
                              Progress(message: 'Carregando Produtos...'),
                          //TODO Loadding carregando da lista
                          listeners: [
                            refreshChangeListener,
                          ],
                          //Change types accordingly
                          itemBuilderType: PaginateBuilderType.listView,
                          // to fetch real-time data
                          isLive: true,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
