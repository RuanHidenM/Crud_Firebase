import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/complements/selectfirebase.dart';
import 'package:flutter/material.dart'; 

Future<void> TrocaEmpresaSelecionada() async {

  await buscandoEmailDoUsuarioLogado().then((value) => userLogadoEmail = value);
  print(userLogadoEmail.toString());

  // FirebaseFirestore.instance
  //     .collection('Usuario')
  //     .doc('teste@emporiofloriano.com.br')
  //     .set({
  //       'Empresas': [
  //         {
  //           'Cnpj' : '01747426000176',
  //           'Fantasia' : 'EMPORIO FLORIANO MATRIZ',
  //           'Logada' : true,
  //           'TenantId': '4c0356cd-c4f7-4901-b247-63e400d56085'
  //         },
  //         {
  //           'Cnpj' : '01747426000180',
  //           'Fantasia' : 'EMPORIO FLORIANO FILIAL',
  //           'Logada' : false,
  //           'TenantId': '4c0356cd-c4f7-4901-b249-63e400d56085'
  //         },
  //       ],
  //     'Nome': 'João Floriano'
  //     });

  var selectUsuario = FirebaseFirestore.instance.collection('Usuario').doc('teste@emporiofloriano.com.br');
  // selectUsuario.update({
  //       'Empresas': [
  //         {
  //           'Cnpj' : '01747426000176',
  //  '         'Fantasia' : 'EMPORIO FLORIANO MATRIZ',
  //           'Logada' : true,
  //           'TenantId': '4c0356cd-c4f7-4901-b247-63e400d56085'
  //         },
  //         {
  //           'Cnpj' : '01747426000180',
  //           'Fantasia' : 'EMPORIO FLORIANO FILIAL',
  //           'Logada' : false,
  //           'TenantId': '4c0356cd-c4f7-4901-b249-63e400d56085'
  //         },
  //       ],
  //     'Nome': 'João Floriano'
  //     });
  
  // selectUsuario.update({
  //   'Empresas' :[{'Fantasia': }],
  // });
}

//Todo : https://firebase.google.com/docs/firestore/manage-data/add-data#web-v8_11