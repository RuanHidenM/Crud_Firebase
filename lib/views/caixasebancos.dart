import 'package:crud_firebase/complements/convertereais.dart';
import 'package:crud_firebase/complements/selectfirebase.dart';
import 'package:crud_firebase/components/botton_title_icon_tipo_filtro_caixaebanco.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CaixaEBanco extends StatefulWidget {
  @override
  _caixasEBancos createState() => _caixasEBancos();
}

class _caixasEBancos extends State<CaixaEBanco> {
  get MediaWidth => MediaQuery.of(context).size.width;
  var snapshotsCaixaEBanco;
  var snapshotsCaixa;
  var snapshotsBanco;
  var valorTotalBaixaEBanco;

  var CNPJDaEmpresaLogada = '';
  bool mostrarValorTotal;
  bool selectedCaixa; //TODO: FILTROS
  bool selectedBanco; //TODO: FILTROS


  _caixasEBancos() {
    BuscandoCaixaEBancoDaEmpresa().then((value) => setState(() {
      snapshotsCaixaEBanco = value;
    }));
    BuscandoCaixaDaEmpresa().then((value) => setState(() {
      snapshotsCaixa = value;
    }));
    BuscandoBancoDaEmpresa().then((value) => setState(() {
      snapshotsBanco = value;
    }));
    BuscandoValorTotalCaixaEBanco().then((value) => setState((){
      valorTotalBaixaEBanco = value;
    }));
  }

  @override
  void initState() {
    super.initState();
    mostrarValorTotal = true;
    setState(() {
      selectedCaixa = false;
      selectedBanco = false;
    });
  }

  Future<List<String>> BuscandoCaixaEBancoDaEmpresa() async {
    await BuscandoCNPJdaEmpresaLogada().then((value) => setState(() {
          CNPJDaEmpresaLogada = value;
        }));
    await BuscandoTenantIdDoUsuarioLogado().then((value) => setState((){
      tenanteIDDoUsuarioLogado = value;
    }));
    snapshotsCaixaEBanco = await FirebaseFirestore.instance
          .collection('Tenant')
          .doc(tenanteIDDoUsuarioLogado.toString())
          .collection('Empresas')
          .doc(CNPJDaEmpresaLogada.toString())
          .collection('CaixaBanco')
          .snapshots();
    return snapshotsCaixaEBanco;
  }

  Future<List<String>> BuscandoCaixaDaEmpresa() async {
    await BuscandoCNPJdaEmpresaLogada().then((value) => setState(() {
      CNPJDaEmpresaLogada = value;
    }));
    await BuscandoTenantIdDoUsuarioLogado().then((value) => setState((){
      tenanteIDDoUsuarioLogado = value;
    }));
    snapshotsCaixa = await FirebaseFirestore.instance
        .collection('Tenant')
        .doc(tenanteIDDoUsuarioLogado.toString())
        .collection('Empresas')
        .doc(CNPJDaEmpresaLogada.toString())
        .collection('CaixaBanco').where('TIPO', isEqualTo: 1)
        .snapshots();
    return snapshotsCaixa;
  }

  Future<List<String>> BuscandoBancoDaEmpresa() async {
    await BuscandoCNPJdaEmpresaLogada().then((value) => setState(() {
      CNPJDaEmpresaLogada = value;
    }));
    await BuscandoTenantIdDoUsuarioLogado().then((value) => setState((){
      tenanteIDDoUsuarioLogado = value;
    }));
    snapshotsBanco = await FirebaseFirestore.instance
        .collection('Tenant')
        .doc(tenanteIDDoUsuarioLogado.toString())
        .collection('Empresas')
        .doc(CNPJDaEmpresaLogada.toString())
        .collection('CaixaBanco').where('TIPO', isEqualTo: 2)
        .snapshots();
    return snapshotsBanco;
  }


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
              'Caixas e Bancos',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),

        // Text('Produtos', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(width: 0.2, color: Colors.black54),
                              )
                          ),
                          width: double.maxFinite,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Investidoss',
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: MediaWidth / 24),
                                ),
                                GestureDetector(
                                  child: Icon(
                                    mostrarValorTotal == true
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.black45,
                                  ),
                                  onTap: () {
                                    if (mostrarValorTotal == true) {
                                      setState(() {
                                        mostrarValorTotal = false;
                                      });
                                    } else {
                                      setState(() {
                                        mostrarValorTotal = true;
                                      });
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child:

                                valorTotalBaixaEBanco == null ?  CircularProgressIndicator(
                                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange)) :
                                mostrarValorTotal == true
                                    ? Text('R\$: ${ConverteReais(valorTotalBaixaEBanco).toString()}',
                                  style: TextStyle(
                                      fontSize: MediaWidth / 13,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold
                                  ),
                                ) : Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.black38,
                                  size: MediaWidth / 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                            child: BottonTitleIconTipoFiltroCaixaeBanxo(
                                'Caixa',
                                Icons.move_to_inbox_outlined,
                                selectedCaixa
                            ),
                          onTap:(){
                              //Todo: CAIXA
                            if(selectedCaixa == false){
                              setState(() {
                                selectedCaixa = true;
                                selectedBanco = false;
                                _caixasEBancos();
                              });
                            }else{
                              setState(() {
                                selectedCaixa = false;
                                _caixasEBancos();
                              });
                            }
                          } ,
                        ),
                        GestureDetector(
                            child: BottonTitleIconTipoFiltroCaixaeBanxo(
                                'Banco',
                                Icons.account_balance_outlined,
                                selectedBanco
                            ),
                          onTap: (){
                             if(selectedBanco == false){
                               setState(() {
                                 selectedBanco = true;
                                 selectedCaixa = false;
                                 _caixasEBancos();
                               });
                             }else{
                               setState(() {
                                 selectedBanco = false;
                                 _caixasEBancos();
                               });
                             }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: StreamBuilder(
              stream: selectedCaixa == true ? snapshotsCaixa :selectedBanco == true ? snapshotsBanco  : snapshotsCaixaEBanco,
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshotsCaixaEBanco == null) {
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
                  ));
                }
                if (snapshot.data.docs.length == 0) {
                  return Center(
                      child: Text('Nenhum Caixas e Bancos Cadastrado!!'));
                }

                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int i) {

                    var caixasebancos = snapshot.data.docs[i];
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 5, right: 5, left: 5),
                        child: Container(
                          height: MediaWidth / 4,
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
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 90,
                                          // color: Colors.yellow,
                                          child: Center(
                                            // child: Icon(Icons.apartment),//banco
                                            child: Icon(
                                              caixasebancos['TIPO'] == 1
                                                  ? Icons.move_to_inbox_outlined
                                                  : Icons.account_balance_outlined,
                                              size: MediaWidth / 10,
                                              color: Colors.orange,
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                      flex: 7,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    15,
                                                //color:Colors.red,
                                                child: Text(
                                                  '${caixasebancos['NOME']}',
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            43,
                                                  ),
                                                )),
                                            Container(
                                                //color:Colors.blue,
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: Icon(
                                                        Icons.monetization_on,
                                                        color: caixasebancos[
                                                                    'SALDO'] >
                                                                0
                                                            ? Colors.green
                                                            : Colors.red,
                                                        size: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            42,
                                                      ),
                                                    ),
                                                    Text(
                                                      'R\$: ',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              50),
                                                    ),
                                                    Text(
                                                      '${ConverteReais(caixasebancos['SALDO'])}',
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(context)
                                                                  .size.height / 42),
                                                    ),
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
                      onDoubleTap: () {},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
