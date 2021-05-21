import 'dart:async';

import 'package:crud_firebase/components/button/circular_button_big_title_color_icon_conect_state.dart';
import 'package:crud_firebase/components/button/circular_button_small_title_color_icon.dart';
import 'package:crud_firebase/firebase/firebase_authentication.dart';
import 'package:crud_firebase/views/caixasebancos.dart';
import 'package:crud_firebase/views/catalogo.dart';
import 'package:crud_firebase/views/createuser_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:provider/provider.dart';

class DrawerSide extends StatefulWidget {
  @override
  _drawerSide createState() => _drawerSide();
}

class _drawerSide extends State<DrawerSide> {

  get MediaWidget => MediaQuery.of(context).size.height;
  var userLogado = FirebaseAuth.instance.currentUser;
  List<String> items = <String>[
    'Açucar Carioca Alimentos',
    'Empresa Demostrativa 01',
    'Empresa Demostrativa 02'
  ];
  String selectedEmpresa = 'Açucar Carioca Alimentos';

  String _connectionStatus = 'UnkNown';
  final Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    //TODO: Verifica o status da conecção
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) {
        setState(() => _connectionStatus = result.toString());
        print('conectss: ${_connectionStatus}');
        if (_connectionStatus == "ConnectivityResult.none") {
          print('sem internet $_connectionStatus');
        }
      },
    );
  }

  //TODO: Verifica o status da conecção
  Future<Null> initConnectivity() async {
    String connectionStatus;
    _connectionStatus = (await _connectivity.checkConnectivity().toString());
    setState(() {
      _connectionStatus = connectionStatus;
    });
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                      child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          //color: Colors.red,
                          child: Column(
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                margin: const EdgeInsets.all(0.0),
                                padding: const EdgeInsets.all(0.0),
                                decoration: BoxDecoration(
                                 // color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(80),
                                  ),
                                ),
                                child: ClipRRect(
                                  child: Image.asset('images/Logo_Mestre_-_Completo.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, left: 7),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ruan Heiden',
                                style: TextStyle(color: Colors.white, fontSize: MediaWidget / 55),
                              ),
                              Text(
                                '${userLogado.email.toString()}',
                                style: TextStyle(color: Colors.white, fontSize: MediaWidget / 55),
                              ),
                              Text(
                                '205.111.049/21.22200',
                                style: TextStyle(color: Colors.white, fontSize: MediaWidget / 55),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //TODO: CONECT
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Icon(
                                        _connectionStatus !=
                                                'ConnectivityResult.none'
                                            ? Icons.wifi
                                            : Icons.wifi_off,
                                        size: MediaWidget / 55,
                                        color: _connectionStatus !=
                                                'ConnectivityResult.none'
                                            ? Colors.lightGreen
                                            : Colors.redAccent),
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
                                        fontSize: MediaWidget / 55),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: DropdownButton<String>(
                          icon: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: const Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          underline: Container(
                            height: 0,
                          ),
                          value: selectedEmpresa,
                          onChanged: (String string) =>
                              setState(() => selectedEmpresa = string),
                          selectedItemBuilder: (BuildContext context) {
                            return items.map<Widget>((String item) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Center(
                                    child: Text(
                                  item,
                                  style: TextStyle(color: Colors.white , fontSize: MediaWidget / 50),
                                )),
                              );
                            }).toList();
                          },
                          items: items.map((String item) {
                            return DropdownMenuItem<String>(
                              child: Text('$item', style: TextStyle(fontSize: MediaWidget / 50),),
                              value: item,
                            );
                          }).toList(),
                        ),
                      ),
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
          ListTile(
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 10),
                  child: Icon(Icons.apps, color: Colors.black54, size: MediaWidget / 20),
                ),
                Text(
                  'Inicial',
                  style: TextStyle(color: Colors.black54, fontSize: MediaWidget / 37),
                ),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 10),
                  child: Icon(Icons.view_list, color: Colors.black54, size: MediaWidget / 20),
                ),
                Text(
                  'Catálogo',
                  style: TextStyle(color: Colors.black54, fontSize: MediaWidget / 37),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Catalogo()));
              },
          ),
          ListTile(
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 10),
                  child: Icon(Icons.bar_chart_sharp, color: Colors.black54, size: MediaWidget / 20),
                ),
                Text(
                  'Relatórios e comissões',
                  style: TextStyle(color: Colors.black54,fontSize: MediaWidget / 37 ),
                ),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 10),
                  child: Icon(Icons.monetization_on, color: Colors.black54, size: MediaWidget / 20),
                ),
                Text(
                  'Caixas e Bancos',
                  style: TextStyle(color: Colors.black54,fontSize: MediaWidget / 37 ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CaixaEBanco()));
            },
          ),
          ListTile(
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 10),
                  child: Icon(Icons.settings, color: Colors.black54, size: MediaWidget / 20),
                ),
                Text(
                  'Configurações',
                  style: TextStyle(color: Colors.black54, fontSize: MediaWidget / 37),
                ),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 10),
                  child: Icon(Icons.logout, color: Colors.black54, size: MediaWidget / 20),
                ),
                Text(
                  'Desconectar',
                  style: TextStyle(color: Colors.black54, fontSize: MediaWidget / 37),
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
                      child: Icon(Icons.autorenew,color: Colors.black26 , size: MediaWidget / 20),
                    ),
                    Column(
                      children: [
                        Text(
                          'Ultima sincronização: ',
                          style: TextStyle(color: Colors.black26, fontSize: MediaWidget / 38),
                        ),
                        Text(
                          '01/05/2021',
                          style: TextStyle(color: Colors.black26, fontSize: MediaWidget / 38),
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
    );
  }
}

//TODO:Drawerside Antigo, orange
/*
* import 'package:crud_firebase/components/button/circular_button_big_title_color_icon.dart';
import 'package:crud_firebase/components/button/circular_button_small_title_color_icon.dart';
import 'package:crud_firebase/components/centered_message.dart';
import 'package:crud_firebase/firebase/firebase_authentication.dart';
import 'package:crud_firebase/views/createuser_page.dart';
import 'package:crud_firebase/views/showmodalfiltro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DrawerSide extends StatelessWidget {
  var userLogado = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CircularButtonBiglTitleColorIcon(
                            corDoIcon: Colors.white,
                            corDobotao: Colors.black,
                            iconDoBotao: Icons.person),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 5),
                      child: Container(
                        //color: Colors.white30,
                        width: 190,
                        height: 70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ruan Heiden',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${userLogado.email.toString()}',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            Text('RH - SISTEMAS LTDA',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  //color: Colors.green,
                  height: 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonBar(
                        children: [
                          Text('Configurações',style: TextStyle(fontSize: 12, color: Colors.white),),
                          Icon(Icons.arrow_forward_ios_outlined,size: 15, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filtrar'),
                CircularButtonSmallTitleColorIcon(
                    iconDoBotao: Icons.search,
                    corDobotao: Colors.white,
                    corDoIcon: Colors.orange)
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(child: ShowModalFiltro());
                  });
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Criar Usuario'),
                CircularButtonSmallTitleColorIcon(
                    iconDoBotao: Icons.person_add,
                    corDoIcon: Colors.green,
                    corDobotao: Colors.white)
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateUserPage(tipo: 'create')));
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Suporte'),
                CircularButtonSmallTitleColorIcon(
                    iconDoBotao: Icons.help_outline_outlined,
                    corDobotao: Colors.white,
                    corDoIcon: Colors.blue)
              ],
            ),
            onTap: () {},
          ),
          Container(
            color: Colors.red[400],
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Desconectar',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  CircularButtonSmallTitleColorIcon(
                      iconDoBotao: Icons.logout,
                      corDoIcon: Colors.red,
                      corDobotao: Colors.white)
                ],
              ),
              onTap: () {
                context.read<AuthenticationService>().signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/
