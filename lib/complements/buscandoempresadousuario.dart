

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crud_firebase/models/empresas.dart';

final String userLogadoEmail = FirebaseAuth.instance.currentUser.email.toString();
var dbUsuario = FirebaseFirestore.instance.collection('Usuario');
var empresas = new List<Empresa>();
var empresasJson;

Future<List<Empresa>> BuscandoEmpresasDoUsuario() async {
  await dbUsuario.where('Email', isEqualTo: userLogadoEmail).get().then((value) async {
    value.docs.forEach((element) {
      empresasJson = element.data()['Empresas'];
      //print('------- ${x.toString()}');
    });
  });
  final List<Empresa> empresas = List();
  for(Map<String, dynamic> element in empresasJson){
    final Empresa empresa = Empresa(
      element['TenantId'],
      element['Enpj'],
      element['logada'],
      element['Id'],
      element['Fantasia'],
    );
    empresas.add(empresa);
  }
  //print('------ ${empresas}');
  return empresas;
}