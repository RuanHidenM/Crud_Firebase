
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crud_firebase/models/empresas.dart';

//TODO: Um alerta de tamanho pequeno, apenas para informa o usuario, sem função
void AlertaTrocaDeEmpresa(context, String nomeEmpresa) {

  // final String userLogadoEmail = FirebaseAuth.instance.currentUser.email.toString();
  // var dbUsuario = FirebaseFirestore.instance.collection('Usuario');
  // var empresas = new List<Empresa>();
  // var empresasJson;
  //
  //
  // Future<void> AlterandoEmpresaPadraoNoFirebase(String nomeEmpresa) async {
  //   empresasJson = await dbUsuario.doc(userLogadoEmail).get().then((value) => value.data());
  //   empresasJson.doc(userLogadoEmail).update({'descrição': 'Criando uma descrição'});
  // }
  //users.doc('userLogadoEmail').update({'descrição': 'Criando uma descrição'});

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Troca da Empresa')),
          content: IntrinsicHeight (
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.store_mall_directory_outlined, color: Color.fromRGBO(36, 82, 108, 30), size: 55),
                      Icon(Icons.double_arrow, color: Colors.orange, size: 30),
                      Icon(Icons.storefront, color: Color.fromRGBO(36, 82, 108, 30), size: 55),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text('Fazer a troca da empresa selecionada para:', textAlign:TextAlign.center),
                        ),
                        Text('$nomeEmpresa.', textAlign:TextAlign.center,style: TextStyle(color: Colors.orange),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            FlatButton(
              child: Text("Não", style: TextStyle(fontSize: MediaQuery.of(context).size.height / 43),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ), FlatButton(
              child: Text("Sim", style: TextStyle(fontSize: MediaQuery.of(context).size.height / 43),),
              onPressed: () {
                Navigator.of(context).pop();
                //AlterandoEmpresaPadraoNoFirebase(nomeEmpresa);
              },
            ),
          ],
        );
      });
}



