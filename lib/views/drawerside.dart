import 'dart:async';

import 'package:crud_firebase/complements/selectfirebase.dart';
import 'package:crud_firebase/firebase/firebase_authentication.dart';
import 'package:crud_firebase/views/caixasebancos.dart';
import 'package:crud_firebase/views/catalogo.dart';
import 'package:crud_firebase/views/config.dart';
import 'package:crud_firebase/views/dropdown_button_empresas.dart';
import 'package:crud_firebase/views/home.dart';
import 'package:crud_firebase/views/screenteste.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';
import 'package:crud_firebase/models/empresas.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DrawerSide extends StatefulWidget {
  _drawerSide createState() => _drawerSide();
}

class _drawerSide extends State<DrawerSide> {
  get MediaHeight => MediaQuery.of(context).size.height;
  var userLogado = FirebaseAuth.instance.currentUser;
  String _connectionStatus = 'UnkNown';
  final Connectivity _connectivity = new Connectivity();
  var nomeEmpresa;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  _drawerSide() {
    buscandoNomeDoUsuario().then((valor) => setState(() {
      nomeEmpresa = valor;
    }));
  }

  Future<Null> initConnectivity() async {
    String connectionStatus;
    _connectionStatus = (await _connectivity.checkConnectivity().toString());
    setState(() {_connectionStatus = connectionStatus;});
  }
  void initState() {
    super.initState();
    //TODO: Verifica o status da conecção
    setState(() {
      initConnectivity();
    });
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) {
        setState(() => _connectionStatus = result.toString());
        print('conects: $_connectionStatus');
        if (_connectionStatus == "ConnectivityResult.none") {
          print('sem internet $_connectionStatus');
        }
      },
    );
  }

  //TODO: Verifica o status da conecção
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaHeight / 2.5,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: MediaHeight / 3.4,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                          child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              //color: Colors.red,
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaHeight / 7,
                                    margin: const EdgeInsets.all(0.0),
                                    decoration: BoxDecoration(
                                     //color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      child: Image.asset(
                                          'logo_emporiofloriano.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: FutureBuilder<List<Empresa>>(
                                future: buscandoEmpresaPadraoDoUsuario(),
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                      break;
                                    case ConnectionState.waiting:
                                      return Center(
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
                                              strokeWidth: 1,
                                            )),
                                      );
                                      break;
                                    case ConnectionState.active:
                                      break;
                                    case ConnectionState.done:
                                      final List<Empresa> empresas = snapshot.data;
                                      return ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            final Empresa empresa = empresas[index];
                                            var maskCNPJ = new MaskTextInputFormatter(mask: '##.###.###/####-##', filter:  { "#": RegExp(r'[0-9]') });
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20, left: 1),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    //'${userLogado.email.toString()}',
                                                    '${nomeEmpresa.toString()}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaHeight / 50),
                                                  ),
                                                  Text(
                                                    '${maskCNPJ.maskText(empresa.cnpj)}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaHeight / 55),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      //TODO: CONECT
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                right: 5),
                                                        child: Icon(
                                                            _connectionStatus !=
                                                                    'ConnectivityResult.none'
                                                                ? Icons.wifi
                                                                : Icons.wifi_off,
                                                            size: MediaHeight / 55,
                                                            color: _connectionStatus !=
                                                                    'ConnectivityResult.none'
                                                                ? Colors.lightGreen
                                                                : Colors.redAccent,
                                                        ),
                                                      ),
                                                      Text(
                                                        _connectionStatus !=
                                                                'ConnectivityResult.none'
                                                            ? 'Conectado'
                                                            : 'Desconectado',
                                                        style: TextStyle(
                                                            color: _connectionStatus !=
                                                                    'ConnectivityResult.none'
                                                                ? Colors.lightGreen
                                                                : Colors.redAccent,
                                                            fontSize:
                                                            MediaHeight / 58),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                      break;
                                  }
                                  return Text('UnkNow error');
                                },
                              )),
                        ],
                      )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        //color: Colors.red,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child:Container(
                            child: DropdownButtonEmpresas(),
                          ),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    //color: Color.fromRGBO(3, 41, 102, 20),
                    gradient: LinearGradient(
                  // begin: Alignment.topRight,
                  // end: Alignment.bottomLeft,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(36, 82, 108, 1),
                    Color.fromRGBO(36, 82, 108, 100),
                  ],
                )),
              ),
            ),
            ListTile(
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 10),
                    child: Icon(Icons.apps,
                        color: Colors.black54, size: MediaHeight / 22),
                  ),
                  Text(
                    'Dashboard',
                    style: TextStyle(
                        color: Colors.black54, fontSize: MediaHeight / 40),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 10),
                    child: Icon(Icons.view_list,
                        color: Colors.black54, size: MediaHeight / 22),
                  ),
                  Text(
                    'Catálogo',
                    style: TextStyle(
                        color: Colors.black54, fontSize: MediaHeight / 40),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Catalogo()));
              },
            ),
            ListTile(
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 10),
                    child: Icon(Icons.bar_chart_sharp,
                        color: Colors.black54, size: MediaHeight / 22),
                  ),
                  Text(
                    'Relatórios e comissões',
                    style: TextStyle(
                        color: Colors.black54, fontSize: MediaHeight / 40),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScreenTeste()));
              },
            ),
            ListTile(
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 10),
                    child: Icon(Icons.monetization_on,
                        color: Colors.black54, size: MediaHeight / 22),
                  ),
                  Text(
                    'Caixas e Bancos',
                    style: TextStyle(
                        color: Colors.black54, fontSize: MediaHeight / 40),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CaixaEBanco()));
              },
            ),
            ListTile(
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 10),
                    child: Icon(Icons.settings,
                        color: Colors.black54, size: MediaHeight / 22),
                  ),
                  Text(
                    'Configurações',
                    style: TextStyle(
                        color: Colors.black54, fontSize: MediaHeight / 40),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ConfigScreen()));
              },
            ),
            ListTile(
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 10),
                    child: Icon(Icons.logout,
                        color: Colors.black54, size: MediaHeight / 22),
                  ),
                  Text(
                    'Desconectar',
                    style: TextStyle(
                        color: Colors.black54, fontSize: MediaHeight / 40),
                  ),
                ],
              ),
              onTap: () {
                context.read<AuthenticationService>().signOut();
              },
            ),
            ListTile(
              title: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black12,
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        child: Icon(Icons.autorenew,
                            color: Colors.black26, size: MediaHeight / 22),
                      ),
                      Column(
                        children: [
                          Text(
                            'Ultima sincronização: ',
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: MediaHeight / 40),
                          ),
                          Text(
                            '01/05/2021',
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: MediaHeight / 40),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
