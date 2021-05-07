//
// import 'package:flutter/material.dart';
// import 'package:listandoapimestre/components/alert/alert_small_title_icon.dart';
// import 'package:listandoapimestre/components/button/button_small_title_icon_color.dart';
// import 'package:listandoapimestre/components/button/circular_button_medium_title_color_icon.dart';
// import 'package:listandoapimestre/components/mytextfield.dart';
// import 'package:listandoapimestre/http/webclient.dart';
// import 'package:listandoapimestre/models/user.dart';
// import 'package:listandoapimestre/screens/homepage.dart';
//
// class LoginScreen extends StatefulWidget {
//   LoginScreen({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   String id;
//   String cnpj;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.white,
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 75, bottom: 45, left: 45,right: 45),
//               child: Container(
//                   child: Image.asset('images/logo_mestre_title_icon_grande.png',
//                     fit: BoxFit.cover, width: MediaQuery.of(context).size.width,)
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 15,),
//               child: Container(
//                 height: 335,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: Color.fromRGBO(3, 71, 102, 10),
//                    borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(80),
//                     bottomRight: Radius.circular(80),
//                   ),
//                 ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           height: 30,
//                           width: 150,
//                           //color: Colors.white,
//                           child: Text(' - Login', style: TextStyle(
//                             fontSize: 22,
//                             color:Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top:8.0, bottom: 0.0, right: 8.0, left: 12.0),
//                           child: Container(
//                             //height: 250,
//                             width: 290,
//                             //color: Colors.white,
//                             child: Padding(
//                               padding: const EdgeInsets.only(bottom: 10),
//                               child: Column(
//                                 children: [
//                                   myTextField(
//                                       titleName: 'E-mail',
//                                       descriptionName: 'Informe seu E-mail',
//                                       changeTypeName:(text){id = text;},
//                                       typeKeyBoard:TextInputType.emailAddress,
//                                       nomeDoComtrolador: null,
//                                       TextTipeMask: null,
//                                   ),
//                                   myTextField(
//                                       titleName: 'Senha',
//                                       descriptionName: 'Informe sua Senha',
//                                       changeTypeName: (text){cnpj = text;},
//                                       typeKeyBoard: TextInputType.visiblePassword,
//                                       nomeDoComtrolador: null,
//                                       TextTipeMask: null,
//                                       obscureText: true
//                                   ),
//                                   GestureDetector(
//                                     child: ButtonSmallTitleIconColor(
//                                         name: 'Entrar',
//                                         iconDoButton: Icons.arrow_forward_ios,
//                                         corDoBotao: Colors.deepOrangeAccent,
//                                         corDoIcon: Colors.white,
//                                         corDoTexto: Colors.white
//                                     ),
//                                     onTap: (){
//                                       //TODO: SE email ou senha for vazil
//                                       if(id.isEmpty || cnpj.isEmpty){
//                                         AlertaSimples(
//                                           context,
//                                           'Falha no Login',
//                                           'E-mail e senha devem ser informados',
//                                           Icons.warning_amber_outlined
//                                         );
//                                       }
//
//                                       //TODO: SE EMAIL E SENHA NÃO FOR VAZIL
//                                       if(id.isNotEmpty && cnpj.isNotEmpty){
//
//                                         print('não estão vazil');
//                                        // FinalLogin(id, cnpj);
//                                         Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title:cnpj.toString())));
//                                       }
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: Container(
//                             height: 49,
//                             width: 290,
//                             //color: Colors.yellow,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 CircularButtonSmallTitleColorIcon(
//                                   corDobotao: Colors.white,
//                                   iconDoBotao: Icons.web,
//                                   corDoIcon: Colors.deepOrange
//                                 ),
//                                 CircularButtonSmallTitleColorIcon(
//                                   corDobotao: Colors.white,
//                                   iconDoBotao: Icons.message,
//                                   corDoIcon: Colors.deepOrange
//                                 ),
//                                 CircularButtonSmallTitleColorIcon(
//                                   corDobotao: Colors.white,
//                                   iconDoBotao: Icons.vpn_key_outlined,
//                                   corDoIcon: Colors.deepOrange
//                                 ),
//                                 CircularButtonSmallTitleColorIcon(
//                                   corDobotao: Colors.white,
//                                   iconDoBotao: Icons.create,
//                                   corDoIcon: Colors.deepOrange
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                  ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

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

  @override
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
                                child: Image.asset('images/pngwing.com.png'),
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
                                            descriptionName:
                                                'Informe seu E-mail',
                                            changeTypeName: (text) {
                                              email = text;
                                            },
                                            typeKeyBoard:
                                                TextInputType.emailAddress,
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
                                            if (email == null ||
                                                senha == null ||
                                                email.isEmpty ||
                                                senha.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Todos os campos deven ser informados !'),
                                              ));
                                            } else {
                                              setState(() {
                                                _loadding = true;
                                              });
                                              await Future.delayed(
                                                  Duration(seconds: 5));
                                              context
                                                  .read<AuthenticationService>()
                                                  .signIn(
                                                    email: email,
                                                    password: senha,
                                                  );
                                              setState(() {
                                                _loadding = false;
                                              });
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
                                                Color.fromRGBO(3, 72, 102, 1),
                                            iconDoBotao: Icons.web,
                                            corDoIcon: Colors.white),
                                        CircularButtonMediunTitleColorIcon(
                                            corDobotao:
                                                Color.fromRGBO(3, 72, 102, 1),
                                            iconDoBotao: Icons.message,
                                            corDoIcon: Colors.white),
                                        CircularButtonMediunTitleColorIcon(
                                            corDobotao:
                                                Color.fromRGBO(3, 72, 102, 1),
                                            iconDoBotao: Icons.vpn_key_outlined,
                                            corDoIcon: Colors.white),
                                        CircularButtonMediunTitleColorIcon(
                                            corDobotao:
                                                Color.fromRGBO(3, 72, 102, 1),
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
                height: 150,
                width: 150,
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
