import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:crud_firebase/components/alert/alert_small_title_icon.dart';
import 'package:crud_firebase/firebase/firebase_authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:crud_firebase/canvas/canvas_screen-login.dart';
import 'package:crud_firebase/components/button/button_small_title_icon_color.dart';
import 'package:crud_firebase/components/button/circular_button_medium_title_color_icon.dart';
import 'package:crud_firebase/components/mytextfield.dart';
import 'package:crud_firebase/components/progress.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static String tag = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email;
  String senha;
  bool _loadding = false;
  String _connectionStatus = 'UnkNown';
  final Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult>_connectivitySubscription;

  @override
  void initState() {

    super.initState();
    //TODO: Verifica o status da conecção
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          setState(() => _connectionStatus = result.toString());
          print('conectss: ${_connectionStatus}');
          if(_connectionStatus == "ConnectivityResult.none"){
            AlertaConectInternet();
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

  void AlertaConectInternet(){//TODO: Alerta de aviso que esta sem internet
    AlertaSimples(
        context,
        'Conexão com a Internet',
        'Para efetuar o login, o dispositivo deve estar conectado a uma internet',
        Icons.wifi_off,
        Colors.red
    );
  }


  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      //resizeToAvoidBottomInset: false,//TODO:Permitindo que a tela se arrume quando o teclado for chamado.
      body: Stack(
        children: [
          Stack(
            //physics: NeverScrollableScrollPhysics(),
            children: [
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.indigo,
                  child: CustomPaint(
                    painter: BackgroundSignIn(),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            //color: Colors.green,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 50, bottom: 10, left: 70, right: 70),
                              child: Container(
                                child: Image.asset('images/Logo_Mestre_-_Completo.png'),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  //color: Colors.indigo,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0, bottom: 10),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Center(
                                              child: Text(
                                                'Login',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        3, 72, 102, 1)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        myTextField(
                                            titleName: 'E-mail',
                                            descriptionName: 'Informe seu E-mail',
                                            changeTypeName: (text) {email = text;},
                                            typeKeyBoard: TextInputType.emailAddress,
                                            nomeDoComtrolador: null,
                                            TextTipeMask: null,
                                            obscureText: false,
                                            colorTextField: Color.fromRGBO(
                                                155, 155, 155, 210)),
                                        myTextField(
                                            titleName: 'Senha',
                                            descriptionName:
                                                'Informe sua Senha',
                                            changeTypeName: (text) {
                                              senha = text;
                                            },
                                            typeKeyBoard:
                                                TextInputType.visiblePassword,
                                            nomeDoComtrolador: null,
                                            TextTipeMask: null,
                                            obscureText: true,
                                            colorTextField: Color.fromRGBO(
                                                155, 155, 155, 210)),
                                        GestureDetector(
                                          child: ButtonSmallTitleIconColor(
                                              name: 'Entrar',
                                              iconDoButton:
                                                  Icons.arrow_forward_ios,
                                              corDoBotao:
                                                  Colors.deepOrangeAccent,
                                              corDoIcon: Colors.white,
                                              corDoTexto: Colors.white),
                                          onTap: () async {
                                            if(_connectionStatus == 'ConnectivityResult.none'){ //TODO; VERIFICA SE TEM INTERNET
                                              AlertaConectInternet();
                                            }else {
                                              if ( //TODO; VERIFICA SE TODOS OS CAMPOS ESTÃO PREECHIDOS
                                              email == null ||
                                                  senha == null ||
                                                  email.isEmpty ||
                                                  senha.isEmpty
                                              ) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                    SnackBar(content:
                                                    Text(
                                                        'Todos os campos deven ser informados !'),));
                                              } else {
                                                setState(() => _loadding =
                                                true); //TODO: Ligando loadding
                                                await Future.delayed(
                                                    Duration(seconds: 5));
                                                context.read<
                                                    AuthenticationService>()
                                                    .signIn(
                                                  email: email,
                                                  password: senha,
                                                );
                                                setState(() => _loadding =
                                                false); //TODO: Desligando loadding
                                                var retornoSignIn = await context
                                                    .read<
                                                    AuthenticationService>()
                                                    .signIn(email: email,
                                                    password: senha);
                                                if (retornoSignIn !=
                                                    'Signed in') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'E-mail ou senha esta incorreto !'),
                                                  ));
                                                }
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  //color: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircularButtonMediunTitleColorIcon(
                                            corDobotao:
                                                Color.fromRGBO(36, 82, 108, 1),
                                            iconDoBotao: Icons.web,
                                            corDoIcon: Colors.white),
                                        CircularButtonMediunTitleColorIcon(
                                            corDobotao:
                                                Color.fromRGBO(36, 82, 108, 1),
                                            iconDoBotao: Icons.message,
                                            corDoIcon: Colors.white),
                                        CircularButtonMediunTitleColorIcon(
                                            corDobotao:
                                                Color.fromRGBO(36, 82, 108, 1),
                                            iconDoBotao: Icons.vpn_key_outlined,
                                            corDoIcon: Colors.white),
                                        CircularButtonMediunTitleColorIcon(
                                            corDobotao:
                                                Color.fromRGBO(36, 82, 108, 1),
                                            iconDoBotao: Icons.create,
                                            corDoIcon: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            child: Center(
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Progress(),
              ),
            ),
            visible: _loadding,
          ),
        ],
      ),
    );
  }
}
