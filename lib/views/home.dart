
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/complements/trocaempresaselecionada.dart';
import 'package:crud_firebase/components/button/button_average_title_icon_color.dart';
import 'package:crud_firebase/views/drawerside.dart';
import 'package:crud_firebase/views/screen_erro_login.dart';
import 'package:crud_firebase/views/screen_mestre_loadding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget{
  _homePage createState() => _homePage();
}

class _homePage extends State<HomePage>{
  get MediaWidth => MediaQuery.of(context).size.width;
  var snapshots;
  String EmailIdentificado;
  var resultado;
  var Empresas2;
  var userLogadoEmail;
  var dbUsuario = FirebaseFirestore.instance.collection('Usuario');
  List<charts.Series<GraficoCaixaEBanco, String>> _seriesPieData;

  _generateDate(){
    var pieData = [
      new GraficoCaixaEBanco('01', 30000.34 , Colors.blue),
      new GraficoCaixaEBanco('02', 20000.51, Colors.orange),
      new GraficoCaixaEBanco('03', 10000.51, Colors.green),
      new GraficoCaixaEBanco('04', 500.51, Colors.black),
    ];

    _seriesPieData.add(
      charts.Series(
        data:pieData,
        domainFn: (GraficoCaixaEBanco nomeCaixaEBanco,_)=> nomeCaixaEBanco.nomeCaixaEBanco,
        measureFn: (GraficoCaixaEBanco nomeCaixaEBanco,_)=> nomeCaixaEBanco.taskvalue,
        colorFn: (GraficoCaixaEBanco nomeCaixaEBanco,_)=> charts.ColorUtil.fromDartColor(nomeCaixaEBanco.colorva1),
        id: 'Daily task',
        labelAccessorFn: (GraficoCaixaEBanco row,_)=> '${row.taskvalue}'
      ),
    );
  }

  void initState(){
    super.initState();
    _seriesPieData = List<charts.Series<GraficoCaixaEBanco, String>>();
    _generateDate();
    setState(() {
      userLogadoEmail = FirebaseAuth.instance.currentUser.email.toString();
      verificaEmailLogadoComEmailCadastrado(userLogadoEmail);
         //snapshots = dbUsuario.where('Email', isEqualTo: userLogadoEmail).snapshots();
         snapshots = dbUsuario.snapshots();
        //BuscandoEmpresaPadraoDoUsuario().then((empresas) => print('Lista de empresas $empresas'));
       // BuscandoEmpresasDoUsuario().then((nomesEmpresas) => print('nomes de empresas $nomesEmpresas'));
    });
  }

  @override
  void verificaEmailLogadoComEmailCadastrado(String userLogadoEmail) async {
    var resultado = await dbUsuario.doc(userLogadoEmail).get().then((value) => value.data());
    resultado == null ? EmailIdentificado = 'invalido': EmailIdentificado = 'valido';
    setState(() {
      EmailIdentificado;
    });
  }

  Widget build(BuildContext context) {
    if(EmailIdentificado != 'valido' && EmailIdentificado != 'invalido'){//Todo: se não for processado ainda, mostrar tela de carregamento
      return ScreenMestreLoadding();
    }
    if(EmailIdentificado == 'valido'){//TODO: Se o usuario for verificado, ele ira se manter nessa tela !!
      return Scaffold(
        drawer:DrawerSide(),
        appBar: AppBar(
          shadowColor: Color.fromRGBO(36, 82, 108, 250),
          //Todo: cor da borda shadow, para ficar mesclado com o widget de filtro a baixo
          backgroundColor: Color.fromRGBO(36, 82, 108, 25),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dashboard', style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
                child: Container(
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          GestureDetector(
                            child: buttonAverageTitleIconColor(
                              corDoBotao: Colors.orange,
                              corDoIcon: Colors.white,
                              corDoTexto: Colors.white,
                              iconDoButton: Icons.wifi_protected_setup,
                              name: 'Trocar empresa'
                            ),
                            onTap: (){
                              TrocaEmpresaSelecionada();
                            },
                          ),

                          Text(
                            'DASHBOARD',
                            style: TextStyle(
                                color: Colors.black12,
                                fontSize: MediaWidth / 10
                            ),
                          ),
                          Text(
                            'O dashboard esta vazio',
                            style: TextStyle(
                                color: Colors.black12,
                                fontSize: MediaWidth / 25
                            ),
                          ),
                          // Expanded(
                          //   child: charts.PieChart(
                          //     _seriesPieData,
                          //     animate: true,
                          //     animationDuration: Duration(seconds: 1),
                          //
                          //     behaviors: [
                          //       new charts.DatumLegend(
                          //         outsideJustification: charts.OutsideJustification.endDrawArea,
                          //         horizontalFirst: true,
                          //         desiredMaxRows: 2,
                          //         cellPadding: new EdgeInsets.only(right: 5.0, bottom: 4.0),
                          //         entryTextStyle: charts.TextStyleSpec(
                          //           color:charts.MaterialPalette.purple.shadeDefault,
                          //           fontFamily: 'Georgia',
                          //           fontSize: 11
                          //         ),
                          //       ),
                          //     ],
                          //
                          //     defaultRenderer: new charts.ArcRendererConfig(
                          //       arcWidth: 50,//TODO: rosca
                          //       arcRendererDecorators: [
                          //         new charts.ArcLabelDecorator(
                          //           labelPosition: charts.ArcLabelPosition.outside,
                          //           insideLabelStyleSpec: charts.TextStyleSpec(
                          //             fontSize: 60,
                          //           )
                          //         )
                          //       ]
                          //     ),
                          //   ),
                          // )
























                        ],
                      ),
                  ),
                )
            )
          ],
        ),
      );
    }else{//Todo: Se o E-mail logado não for encontrado no banco, retornara uma tela erro.
      return ErroNoLogin();
    }
  }
}

class GraficoCaixaEBanco{
  String nomeCaixaEBanco;
  double taskvalue;
  Color colorva1;

  GraficoCaixaEBanco(this.nomeCaixaEBanco, this.taskvalue, this.colorva1);
}
