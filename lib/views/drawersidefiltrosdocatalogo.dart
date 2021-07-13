import 'dart:async';
import 'dart:math';

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

import '../globals.dart';

class DrawerSideFiltrosCatalogo extends StatefulWidget {
  _drawerSideFiltrosCatalogo createState() => _drawerSideFiltrosCatalogo();
}

class _drawerSideFiltrosCatalogo extends State<DrawerSideFiltrosCatalogo> {
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
    setState(() {
      _connectionStatus = connectionStatus;
    });
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
    return
      Container(
      width: MediaHeight / 3,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: MediaHeight / 5.0,
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
                          size: MediaHeight / 25,
                        ),
                        Text(
                          'Filtro Catalogo',
                          style: TextStyle(
                              color: Colors.white, fontSize: MediaHeight / 35),
                        ),
                      ],
                    ),
                    Text('Selecione uma das opções para efetuar o filtro no catalogo.', style: TextStyle(color: Colors.white70),),
                  ],
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topCenter,
                  colors: [
                    Color.fromRGBO(36, 82, 108, 1),//TODO Azul 4/4
                    Color.fromRGBO(36, 82, 108, 15),//TODO AZUL 3/4. BRANCO 1/4
                    Color.fromRGBO(36, 82, 108, 30),//TODO AZUL 2/4, BRANCO 2/4
                    Color.fromRGBO(36, 82, 108, 45),//TODO AZUL 1/4, BRANCO 3/4
                    Color.fromRGBO(36, 82, 108, 50),//TODO BRANCO 4/4
                  ],
                  ),
                ),
              ),
            ),
            Container(
             color: Colors.black12,//TODO Cor se for selecoinado
              //TODO: Se não for selecionado recebe o white
              child: ListTile(
                title: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 10),
                        child:
                        filtroCatalogoOrdenarValor == true ?
                        Icon(Icons.filter_list_rounded, color: Colors.black54, size: MediaHeight / 25)
                            :
                            Transform.rotate(
                              angle: 180 * pi / 180,
                              child:  Icon(Icons.filter_list_rounded, color: Colors.black54, size: MediaHeight / 25),
                            )
                      ),
                      Text(
                        filtroCatalogoOrdenarValor == true ?
                        'Ordenando maior valor'
                        :
                        'Ordenando menor valor',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: MediaHeight / 48
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  if(filtroCatalogoOrdenarValor == true){
                    setState(() {
                      filtroCatalogoOrdenarValor = false;
                    });
                  }else{
                    setState(() {
                      filtroCatalogoOrdenarValor = true;
                    });
                  }

                  Navigator.of(context).pop();

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
