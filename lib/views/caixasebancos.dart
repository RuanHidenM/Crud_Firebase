import 'dart:convert';
import 'dart:typed_data';

import 'package:crud_firebase/complements/calculaporcentagementredoisvalores.dart';
import 'package:crud_firebase/complements/convertereais.dart';
import 'package:crud_firebase/complements/selectfirebase.dart';
import 'package:crud_firebase/components/botton_title_icon_tipo_filtro_caixaebanco.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:crud_firebase/globals.dart' as globals;

class CaixaEBanco extends StatefulWidget {
  @override
  _caixasEBancos createState() => _caixasEBancos();
}

class _caixasEBancos extends State<CaixaEBanco> {
  get MediaWidth => MediaQuery.of(context).size.width;
  var snapshotsCaixaEBanco; //TODO: Select do CaixaeBanco
  var snapshotsCaixa; //TODO: Select do Caixa
  var snapshotsBanco; //TODO: Select do Banco
  var snapshotsCaixaEBancoNegativo; //TODO: Select Negativo

  var valorTotalCaixaEBanco; //TODO Valor total CaixaeBanco
  var valorTotalCaixa; //TODO: Valor total Caixa
  var valorTotalBanco; //TODO: Valor total BANCO
  var valorTotalNegativo; //TODO: Valor total NEGATIVO

  var CNPJDaEmpresaLogada = ''; //TODO: CNPJ da empresa logada para os selects

  bool mostrarValorTotal;
  bool selectedCaixa; //TODO: Botão filtro CAIXA
  bool selectedBanco; //TODO: Botão filtro BANCO
  bool selectNegativo; //TODO: Botão filtro NEGATIVO
  List<charts.Series<GraficoCaixaEBanco, String>> _seriesPieData;

  _generateData({
    String variNome,
    double variValor,
    Color variColorgraf,
    String totalNome,
    double totalValor,
    Color totalColorgraf,
  }) {
    var pieData = [
      new GraficoCaixaEBanco('$variNome', variValor, variColorgraf),
      new GraficoCaixaEBanco('$totalNome', totalValor, totalColorgraf),
    ];
    _seriesPieData.add(
      charts.Series(
          data: pieData,
          domainFn: (GraficoCaixaEBanco nomeCaixaEBanco, _) =>
              nomeCaixaEBanco.nomeCaixaEBanco,
          measureFn: (GraficoCaixaEBanco nomeCaixaEBanco, _) =>
              nomeCaixaEBanco.graficValue,
          colorFn: (GraficoCaixaEBanco nomeCaixaEBanco, _) =>
              charts.ColorUtil.fromDartColor(nomeCaixaEBanco.graficColor),
          id: 'Grafigo Caixa e Banco',
          labelAccessorFn: (GraficoCaixaEBanco row, _) => '${row.graficValue}'),
    );
  }

  _caixasEBancos() {
    buscandoCaixaEBancoDaEmpresa().then((value) => setState(() {
          snapshotsCaixaEBanco = value;
        }));
    BuscandoCaixaDaEmpresa().then((value) => setState(() {
          snapshotsCaixa = value;
        }));
    BuscandoBancoDaEmpresa().then((value) => setState(() {
          snapshotsBanco = value;
        }));
    BuscandoCaixaEBancoNegativoDaEmpresa().then((value) => setState(() {
      snapshotsCaixaEBancoNegativo = value;
    }));
    buscandoValorTotalCaixaEBanco().then((value) => setState(() {
          valorTotalCaixaEBanco = value;
        }));
    buscandoValorTotalCaixa().then((value) => setState(() {
          valorTotalCaixa = value;
        }));
    buscandoValorTotalBanco().then((value) => setState(() {
          valorTotalBanco = value;
        }));
    buscandoValorTotalSaldoNegativo().then((value) => setState(() {
          valorTotalNegativo = value;
    }));

  }

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedCaixa = false;
      selectedBanco = false;
    });
  }

  Future<List<String>> buscandoCaixaEBancoDaEmpresa() async {
    await buscandoCNPJdaEmpresaLogada().then((value) => setState(() {
          CNPJDaEmpresaLogada = value;
        }));
    await buscandoTenantIdDoUsuarioLogado().then((value) => setState(() {
          tenanteIDDoUsuarioLogado = value;
        }));
    snapshotsCaixaEBanco = await FirebaseFirestore.instance
        .collection('Tenant')
        .doc(tenanteIDDoUsuarioLogado.toString())
        .collection('Empresas')
        .doc(CNPJDaEmpresaLogada.toString())
        .collection('CaixaBanco')
        .orderBy('SALDO', descending: true)
        .snapshots();
    return snapshotsCaixaEBanco;
  }

  Future<List<String>> BuscandoCaixaDaEmpresa() async {
    await buscandoCNPJdaEmpresaLogada().then((value) => setState(() {
          CNPJDaEmpresaLogada = value;
        }));
    await buscandoTenantIdDoUsuarioLogado().then((value) => setState(() {
          tenanteIDDoUsuarioLogado = value;
        }));
    snapshotsCaixa = await FirebaseFirestore.instance
        .collection('Tenant')
        .doc(tenanteIDDoUsuarioLogado.toString())
        .collection('Empresas')
        .doc(CNPJDaEmpresaLogada.toString())
        .collection('CaixaBanco')
        .where('TIPO', isEqualTo: 1)
        .orderBy('SALDO', descending: true)
        .snapshots();
    return snapshotsCaixa;
  }

  Future<List<String>> BuscandoBancoDaEmpresa() async {
    await buscandoCNPJdaEmpresaLogada().then((value) => setState(() {
          CNPJDaEmpresaLogada = value;
        }));
    await buscandoTenantIdDoUsuarioLogado().then((value) => setState(() {
          tenanteIDDoUsuarioLogado = value;
        }));
    snapshotsBanco = await FirebaseFirestore.instance
        .collection('Tenant')
        .doc(tenanteIDDoUsuarioLogado.toString())
        .collection('Empresas')
        .doc(CNPJDaEmpresaLogada.toString())
        .collection('CaixaBanco')
        .where('TIPO', isEqualTo: 2)
        .orderBy('SALDO', descending: true)
        .snapshots();
    return snapshotsBanco;
  }

  Future<List<String>> BuscandoCaixaEBancoNegativoDaEmpresa() async {
    await buscandoCNPJdaEmpresaLogada().then((value) => setState(() {
          CNPJDaEmpresaLogada = value;
        }));
    await buscandoTenantIdDoUsuarioLogado().then((value) => setState(() {
          tenanteIDDoUsuarioLogado = value;
        }));
    snapshotsCaixaEBancoNegativo = await FirebaseFirestore.instance
        .collection('Tenant')
        .doc(tenanteIDDoUsuarioLogado.toString())
        .collection('Empresas')
        .doc(CNPJDaEmpresaLogada.toString())
        .collection('CaixaBanco')
        .where('SALDO', isLessThanOrEqualTo: 0)
        .orderBy('SALDO', descending: false)
        .snapshots();
    return snapshotsCaixaEBancoNegativo;
  }

  Widget build(BuildContext context) {
    if (globals.mostrarValorTotal == null) {
      setState(() {
        globals.mostrarValorTotal = true;
      });
    }
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              //Todo: fazer o efeito de esconder
              snap: false,
              //Todo: Aparecer na primeira scrollzada pra cima
              floating: false,
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromRGBO(36, 82, 108, 25),
              shadowColor: Color.fromRGBO(36, 82, 108, 250),

              expandedHeight: MediaWidth / 2,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  //color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, right: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedBanco == true
                                        ? 'Banco Investido '
                                        : selectedCaixa == true
                                            ? 'Caixa Investido '
                                            : selectNegativo == true
                                                ? 'Total Negativo'
                                                : 'Total Investido',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: MediaWidth / 21,
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      globals.mostrarValorTotal != true
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: Colors.white70,
                                      size: MediaWidth / 16,
                                    ),
                                    onTap: () {
                                      if (globals.mostrarValorTotal == true) {
                                        setState(() {
                                          globals.mostrarValorTotal = false;
                                        });
                                      } else {
                                        setState(() {
                                          globals.mostrarValorTotal = true;
                                        });
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 10),
                              child: Container(
                                height: 0.3,
                                width: double.infinity,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: MediaWidth / 5,
                          width: double.infinity,
                          // color: Colors.red,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        child:
                                            BottonTitleIconTipoFiltroCaixaeBanxo(
                                                'Caixa',
                                                Icons.move_to_inbox_outlined,
                                                selectedCaixa),
                                        onTap: () {
                                          //Todo: CAIXA
                                          if (selectedCaixa == false) {
                                            setState(() {
                                              selectedCaixa = true;
                                              selectedBanco = false;
                                              selectNegativo = false;
                                              _caixasEBancos();
                                            });
                                          } else {
                                            setState(() {
                                              selectedCaixa = false;
                                              _caixasEBancos();
                                            });
                                          }
                                        },
                                      ),
                                      GestureDetector(
                                        child:
                                            BottonTitleIconTipoFiltroCaixaeBanxo(
                                                'Banco',
                                                Icons.account_balance_outlined,
                                                selectedBanco),
                                        onTap: () {
                                          if (selectedBanco == false) {
                                            setState(() {
                                              selectedBanco = true;
                                              selectedCaixa = false;
                                              selectNegativo = false;
                                              _caixasEBancos();
                                            });
                                          } else {
                                            setState(() {
                                              selectedBanco = false;
                                              _caixasEBancos();
                                            });
                                          }
                                        },
                                      ),
                                      GestureDetector(
                                        child:
                                            BottonTitleIconTipoFiltroCaixaeBanxo(
                                                'Negativo',
                                                Icons.remove,
                                                selectNegativo),
                                        onTap: () {
                                          if (selectNegativo == false) {
                                            setState(() {
                                              selectedBanco = false;
                                              selectedCaixa = false;
                                              selectNegativo = true;
                                              _caixasEBancos();
                                            });
                                          } else {
                                            setState(() {
                                              selectNegativo = false;
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
                      ],
                    ),
                  ),
                ),
                titlePadding: EdgeInsets.only(bottom: 0),
                title: Container(
                    //color: Colors.green,
                    height: MediaWidth / 2.5,
                    width: double.infinity,
                    child: Container(
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            valorTotalCaixaEBanco != null
                                ? globals.mostrarValorTotal != true
                                    ? Icon(
                                        Icons.visibility_off_outlined,
                                        color: Colors.white70,
                                        size: MediaWidth / 15,
                                      )
                                    : Text(
                                        'R\$: ${converteReais(selectedCaixa == true ? valorTotalCaixa : selectedBanco == true ? valorTotalBanco : selectNegativo == true ? valorTotalNegativo : valorTotalCaixaEBanco)}')
                                : Container(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Color.fromRGBO(245, 134, 52, 1),
                                      strokeWidth: 2,
                                    ),
                                  )
                          ],
                        ),
                        onTap: () {
                          if (globals.mostrarValorTotal == true) {
                            setState(() {
                              globals.mostrarValorTotal = false;
                            });
                          } else {
                            setState(() {
                              globals.mostrarValorTotal = true;
                            });
                          }
                        },
                      ),
                    )),
              ),
            ),
            StreamBuilder(
                stream: selectedCaixa == true
                    ? snapshotsCaixa
                    : selectedBanco == true
                        ? snapshotsBanco
                        : selectNegativo == true //TODO RUAN
                            ? snapshotsCaixaEBancoNegativo
                            : snapshotsCaixaEBanco,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 20,
                        child: Center(
                          child: Text('Error: ${snapshot.error}'),
                        ),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshotsCaixaEBanco == null) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 60,
                        child: Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color.fromRGBO(245, 134, 52, 1)),
                              ),
                              Text(
                                'Carregando...',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  if (snapshot.data.docs.length == 0) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        child: Center(
                            child: Text(
                          'Nenhum Caixas e Bancos Cadastrado',
                          style: TextStyle(color: Colors.grey),
                        )),
                      ),
                    );
                  }

                  if (valorTotalCaixaEBanco == null) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: 60,
                        child: Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color.fromRGBO(245, 134, 52, 1)),
                              ),
                              Text(
                                'Carregando...',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                   return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var caixasebancos = snapshot.data.docs[index];


                        //Uint8List bytesImg = base64Decode(caixasebancos['LOGO']);
                        Uint8List bytesImg = base64Decode('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');

                        _seriesPieData =
                            List<charts.Series<GraficoCaixaEBanco, String>>();
                        if (caixasebancos['SALDO'] >= 0) {
                          _generateData(
                            variNome: 'subtotal',
                            variValor: caixasebancos['SALDO'],
                            variColorgraf: Colors.green,
                            totalNome: 'total',
                            totalValor: selectedCaixa == true
                                ? valorTotalCaixa - caixasebancos['SALDO']
                                : selectedBanco == true
                                    ? valorTotalBanco - caixasebancos['SALDO']
                                    : selectNegativo == true
                                        ? valorTotalNegativo
                                        : valorTotalCaixaEBanco - caixasebancos['SALDO'],
                            totalColorgraf: Colors.black12,
                          );
                        } else {
                          //TODO  REMOVENDO '-' DO VALOR SUBTOTAL
                          String caixaebancoNegativoString = caixasebancos['SALDO'].toString().replaceAll('-', '');
                          double caixaebancoNegativoDouble = double.parse(caixaebancoNegativoString);

                          //TODO REMOVENDO '-' DO VALOR TOTAL
                           String caixaebancoNegativototalString = valorTotalNegativo.toString().replaceAll('-', '');
                           double caixaebancoNegativototalDouble = double.parse(caixaebancoNegativototalString);

                          _generateData(
                            variNome: 'subtotal',
                            variValor: caixaebancoNegativoDouble,
                            variColorgraf: Colors.red,
                            totalNome: 'total',
                            totalValor: selectedCaixa == true
                                ? valorTotalCaixa
                                : selectedBanco == true
                                    ? valorTotalBanco
                                    : selectNegativo == true
                                    ? caixaebancoNegativototalDouble - caixaebancoNegativoDouble
                                        : valorTotalCaixaEBanco,
                            totalColorgraf: Colors.black12,
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            children: [
                              Container(
                                  height: MediaWidth / 3.5,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Stack(
                                          children: [
                                            Container(
                                                //color: Colors.red,
                                                height: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: charts.PieChart(
                                                        _seriesPieData,
                                                        animate: true,
                                                        animationDuration:
                                                            Duration(seconds: 1),
                                                        defaultRenderer: new charts
                                                            .ArcRendererConfig(
                                                          arcWidth: 7, //TODO: rosca
                                                          //arcRendererDecorators: [
                                                          // new charts.ArcLabelDecorator(
                                                          //     labelPosition: charts.ArcLabelPosition.inside,
                                                          //     insideLabelStyleSpec: charts.TextStyleSpec(
                                                          //       fontSize: 6,
                                                          //     )
                                                          // )
                                                          //]
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            Center(
                                              child: Text(
                                                '${calcularPorcentagemEntreDoisValores(subValor: caixasebancos['SALDO'], total: selectedCaixa == true ? valorTotalCaixa : selectedBanco == true ? valorTotalBanco : selectNegativo == true ? valorTotalNegativo : valorTotalCaixaEBanco)}%',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: MediaWidth / 25),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          height: double.infinity,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                  width: 0.6,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Container(
                                                    width: double.infinity,
                                                    child: Text(
                                                      caixasebancos['NOME'],
                                                      style: TextStyle(
                                                          fontSize:
                                                              MediaWidth / 25,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    width: double.infinity,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            caixasebancos['TIPO'] == 2 ?
                                                            Container(
                                                                height: 20,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.green,
                                                                    image: DecorationImage(
                                                                        image: MemoryImage(bytesImg)
                                                                    )
                                                                )
                                                            )
                                                            :
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.account_balance_outlined,
                                                                  color: Colors.orange,
                                                                ),
                                                                Text(  'CAIXA',
                                                                  style: TextStyle(
                                                                    color: Colors.black54,
                                                                    fontSize: MediaWidth / 29,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.monetization_on_outlined,
                                                              size: MediaWidth / 20,
                                                              color: caixasebancos['SALDO'] > 0 ? Colors.green
                                                                  : caixasebancos['SALDO'] == 0 ? Colors.black38
                                                                  : Colors.red,
                                                            ),
                                                            Text(
                                                              ' R\$: ${converteReais(caixasebancos['SALDO'])}',
                                                              style: TextStyle(
                                                                fontSize: MediaWidth / 25,
                                                                color: Colors.black54,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Container(
                                height: 0.5,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        );
                      },
                      childCount: snapshot.data.docs.length,
                    ),
                  );
                }),
          ],
        ));
  }
}

class GraficoCaixaEBanco {
  String nomeCaixaEBanco;
  double graficValue;
  Color graficColor;

  GraficoCaixaEBanco(this.nomeCaixaEBanco, this.graficValue, this.graficColor);
}
