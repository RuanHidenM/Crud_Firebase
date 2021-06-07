import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/firebase/firebase_authentication.dart';
import 'package:crud_firebase/views/drawerside.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ErroNoLogin extends StatefulWidget{
  _erroNoLogin createState() => _erroNoLogin();
}

class _erroNoLogin extends State<ErroNoLogin>{

  get MediaWidth => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   shadowColor: Color.fromRGBO(36, 82, 108, 250),
      //   //Todo: cor da borda shadow, para ficar mesclado com o widget de filtro a baixo
      //   backgroundColor: Color.fromRGBO(36, 82, 108, 25),
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text('Problemas no login', style: TextStyle(color: Colors.white),),
      //     ],
      //   ),
      // ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: MediaQuery.of(context).size.height /2 ,
                    width: double.infinity,
                    //color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.warning_amber_outlined, color: Colors.red, size: MediaWidth / 5,),
                            Text('Problema no login', style: TextStyle(fontSize: 30),),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('    O E-mail informado foi cadastrado em nosso sistema,'
                              'porém não foi encontrado no banco de dados, para a segurança dos demais usuarios, '
                              'este E-mail esta suspenso temporariamente, por favor entre'
                              ' em contato com o suporte Mestre. ', style: TextStyle(fontSize: 19, color: Colors.black54),),
                        ),
                      ],
                    )
                ),
              ),
              ListTile(
                hoverColor: Colors.orange,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 10),
                      child: Icon(Icons.attach_email_outlined, color: Colors.black54, size: 35),
                    ),
                    Text('Suporte MESTRE', style: TextStyle(color: Colors.black54, fontSize: 25),),
                  ],
                ),
                onTap: () {
                  //TODO: Link do suporte mestre
                },
              ),ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 10),
                      child: Icon(Icons.logout, color: Colors.black54, size: 35),
                    ),
                    Text('Voltar para o login', style: TextStyle(color: Colors.black54, fontSize: 25),),
                  ],
                ),
                onTap: () {
                  context.read<AuthenticationService>().signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}