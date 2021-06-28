import 'package:crud_firebase/complements/convertereais.dart';
import 'package:crud_firebase/complements/selectfirebase.dart';
import 'package:crud_firebase/components/botton_title_icon_tipo_filtro_caixaebanco.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CaixaEBanco extends StatefulWidget {
  @override
  _caixasEBancos createState() => _caixasEBancos();
}

class _caixasEBancos extends State<CaixaEBanco> {
  get MediaWidth => MediaQuery.of(context).size.width;
  var snapshotsCaixaEBanco;
  var snapshotsCaixa;
  var snapshotsBanco;
  var snapshotsCaixaEBancoNegativo;
  var valorTotalCaixaEBanco;

  var valorTotalCaixa;
  var valorTotalBanco;
  var valorTotalNegativo;

  var CNPJDaEmpresaLogada = '';

  bool mostrarValorTotal;
  bool selectedCaixa; //TODO: FILTROS
  bool selectedBanco; //TODO: FILTROS
  bool selectNegativo; //TODO: NEGATIVO
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
    BuscandoCaixaEBancoDaEmpresa().then((value) => setState(() {
          snapshotsCaixaEBanco = value;
        }));
    BuscandoCaixaDaEmpresa().then((value) => setState(() {
          snapshotsCaixa = value;
        }));
    BuscandoBancoDaEmpresa().then((value) => setState(() {
          snapshotsBanco = value;
        }));
    BuscandoValorTotalCaixaEBanco().then((value) => setState(() {
          valorTotalCaixaEBanco = value;
        }));
    BuscandoValorTotalCaixa().then((value) => setState(() {
          valorTotalCaixa = value;
        }));
    BuscandoValorTotalBanco().then((value) => setState(() {
          valorTotalBanco = value;
        }));
    BuscandoValorTotalSaldoNegativo().then((value) => setState(() {
          valorTotalNegativo = value;
        }));
    BuscandoCaixaEBancoNegativoDaEmpresa().then((value) => setState(() {
          valorTotalNegativo = value;
        }));
  }

  @override
  void initState() {
    super.initState();
    //_seriesPieData = List<charts.Series<GraficoCaixaEBanco, String>>();
    //_generateData(nome: 'dale', valor: 500.0);

    mostrarValorTotal = true;
    setState(() {
      //_generateData();
      selectedCaixa = false;
      selectedBanco = false;
    });
  }

  Future<List<String>> BuscandoCaixaEBancoDaEmpresa() async {
    await BuscandoCNPJdaEmpresaLogada().then((value) => setState(() {
          CNPJDaEmpresaLogada = value;
        }));
    await BuscandoTenantIdDoUsuarioLogado().then((value) => setState(() {
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
    await BuscandoCNPJdaEmpresaLogada().then((value) => setState(() {
          CNPJDaEmpresaLogada = value;
        }));
    await BuscandoTenantIdDoUsuarioLogado().then((value) => setState(() {
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
    await BuscandoCNPJdaEmpresaLogada().then((value) => setState(() {
          CNPJDaEmpresaLogada = value;
        }));
    await BuscandoTenantIdDoUsuarioLogado().then((value) => setState(() {
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
    await BuscandoCNPJdaEmpresaLogada().then((value) => setState(() {
          CNPJDaEmpresaLogada = value;
        }));
    await BuscandoTenantIdDoUsuarioLogado().then((value) => setState(() {
          tenanteIDDoUsuarioLogado = value;
        }));
    snapshotsCaixaEBancoNegativo = await FirebaseFirestore.instance
        .collection('Tenant')
        .doc(tenanteIDDoUsuarioLogado.toString())
        .collection('Empresas')
        .doc(CNPJDaEmpresaLogada.toString())
        .collection('CaixaBanco')
        .where('SALDO', isLessThanOrEqualTo: 0)
        .orderBy('SALDO', descending: true)
        .snapshots();
    return snapshotsCaixaEBancoNegativo;
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
                                      mostrarValorTotal == true
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: Colors.white70,
                                      size: MediaWidth / 16,
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
                                ? mostrarValorTotal == true
                                    ? Text(
                                        'R\$: ${ConverteReais(selectedCaixa == true ? valorTotalCaixa : selectedBanco == true ? valorTotalBanco : selectNegativo == true ? valorTotalNegativo : valorTotalCaixaEBanco)}')
                                    : Icon(
                                        Icons.visibility_off_outlined,
                                        color: Colors.white70,
                                        size: MediaWidth / 15,
                                      )
                                : Container(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.orange,
                                      strokeWidth: 2,
                                    ),
                                  )
                          ],
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
                                    Colors.orange),
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
                                    Colors.orange),
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

                        _seriesPieData =
                            List<charts.Series<GraficoCaixaEBanco, String>>();
                        print('Total valor ${valorTotalCaixaEBanco}');

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
                                        : valorTotalCaixaEBanco -
                                            caixasebancos['SALDO'],
                            totalColorgraf: Colors.black12,
                          );
                        } else {
                          String caixaebancoNegativoString =
                              caixasebancos['SALDO']
                                  .toString()
                                  .replaceAll('-', '');
                          double caixaebancoNegativoDouble =
                              double.parse(caixaebancoNegativoString);

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
                                        ? valorTotalNegativo -
                                            caixasebancos['SALDO']
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
                                                child: Expanded(
                                                  child: charts.PieChart(
                                                    _seriesPieData,
                                                    animate: true,
                                                    animationDuration:
                                                        Duration(seconds: 1),
                                                    defaultRenderer: new charts
                                                        .ArcRendererConfig(
                                                      arcWidth: 8, //TODO: rosca
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
                                                )),
                                            Center(
                                              child: Text(
                                                '10%',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: MediaWidth / 20),
                                              ),
                                            )
                                          ],
                                        ),
                                        // child: Container(
                                        //   //color: Colors.red,
                                        //   height: double.infinity,
                                        //   child:   Expanded(
                                        //     child: charts.PieChart(
                                        //       _seriesPieData,
                                        //       animate: true,
                                        //       animationDuration: Duration(seconds: 1),
                                        //       defaultRenderer: new charts.ArcRendererConfig(
                                        //           arcWidth: 8, //TODO: rosca
                                        //           //arcRendererDecorators: [
                                        //             // new charts.ArcLabelDecorator(
                                        //             //     labelPosition: charts.ArcLabelPosition.inside,
                                        //             //     insideLabelStyleSpec: charts.TextStyleSpec(
                                        //             //       fontSize: 6,
                                        //             //     )
                                        //             // )
                                        //             //]
                                        //       ),
                                        //     ),
                                        //   )
                                        // ),
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
                                                            Icon(
                                                              caixasebancos[
                                                                          'TIPO'] ==
                                                                      2
                                                                  ? Icons
                                                                      .account_balance_outlined
                                                                  : Icons
                                                                      .move_to_inbox_outlined,
                                                              color:
                                                                  Colors.orange,
                                                            ),
                                                            Text(
                                                              caixasebancos[
                                                                          'TIPO'] ==
                                                                      2
                                                                  ? 'BANCO'
                                                                  : 'CAIXA',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize:
                                                                    MediaWidth /
                                                                        29,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .monetization_on_outlined,
                                                              size: MediaWidth /
                                                                  20,
                                                              color: caixasebancos[
                                                                          'SALDO'] >
                                                                      0
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                            ),
                                                            Text(
                                                              ' R\$: ${ConverteReais(caixasebancos['SALDO'])}',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    MediaWidth /
                                                                        25,
                                                                color: Colors
                                                                    .black54,
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
