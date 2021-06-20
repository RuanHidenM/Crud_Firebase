import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crud_firebase/models/empresas.dart';
import 'package:firebase_database/firebase_database.dart';

final String userLogadoEmail = FirebaseAuth.instance.currentUser.email.toString();
var dbUsuario = FirebaseFirestore.instance.collection('Usuario');
var empresasJson;
var caixaEBancoJson;
var caixaEBancoJsonLength;
var prod;
var produtosDoUsuario;
var valorPadraoDoProduto;
final double valorDoProdutoQueForSim = 0;
var tabelaPrecoJsonlength;
var CNPJDaEmpresaLogada = '';

Future<List<Empresa>> BuscandoEmpresaPadraoDoUsuario() async {
  empresasJson = await dbUsuario.doc(userLogadoEmail).get().then((value) => value.data());
  final List<Empresa> empresas = List();
  for(Map<String, dynamic> element in empresasJson['Empresas']){
    final Empresa empresa = Empresa(
      element['TenantId'],
      element['Cnpj'],
      element['Logada'],
      element['Fantasia'],
    );
    empresas.add(empresa);
  }
  //TODO: Buscando apenas os valores que tem tipo do do valor informado.
  List<Empresa> EmpresaQueForTrue = empresas.where((element) => element.logada == true).toList();

  return EmpresaQueForTrue;
}

Future<String> BuscandoNomeDoUsuario() async {
  empresasJson = await dbUsuario.doc(userLogadoEmail).get().then((value) => value.data());
  return empresasJson['Nome'];
}

Future<List<String>> BuscandoEmpresasDoUsuario() async {
  empresasJson = await dbUsuario.doc(userLogadoEmail).get().then((value) => value.data());
  //final List<Empresa> empresas = List();
  final List<String> nomesEmpresas = List();
  for(Map<String, dynamic> element in empresasJson['Empresas']){
    final Empresa empresa = Empresa(
      element['TenantId'],
      element['Cnpj'],
      element['Logada'],
      element['Fantasia'],
    );
    nomesEmpresas.add(empresa.fantasia.toString());
  }
  return nomesEmpresas;
}

Future<String> BuscandoNomeEmpresaPadraoDoUsuario() async {
  empresasJson = await dbUsuario.doc(userLogadoEmail).get().then((value) => value.data());

  final List<String> nomesEmpresas = List();
  for(Map<String, dynamic> element in empresasJson['Empresas']){
    final Empresa empresa = Empresa(
      element['TenantId'],
      element['Cnpj'],
      element['Logada'],
      element['Fantasia'],
    );
    if(empresa.logada == true){
      nomesEmpresas.add(empresa.fantasia);
    }
  }
  String EmpresaPadaoselecionada = nomesEmpresas.toString();
  String EmpresaPadaoselecionada1 = EmpresaPadaoselecionada.replaceAll("[", "");
  String EmpresaPadaoselecionada2 = EmpresaPadaoselecionada1.replaceAll("]", "");
  return EmpresaPadaoselecionada2;
}

Future<String> BuscandoCNPJdaEmpresaLogada () async{
  empresasJson = await dbUsuario.doc(userLogadoEmail).get().then((value) => value.data());
  final List<String> nomesEmpresas = List();
  for(Map<String, dynamic> element in empresasJson['Empresas']){
    final Empresa empresa = Empresa(
      element['TenantId'],
      element['Cnpj'],
      element['Logada'],
      element['Fantasia'],
    );
    if(empresa.logada == true){
      nomesEmpresas.add(empresa.cnpj);
    }
  }
  return nomesEmpresas.toString().replaceAll("[", "").replaceAll("]", "");
}

Future<double> BuscandoValorTotalCaixaEBanco () async{
  await BuscandoCNPJdaEmpresaLogada().then((value) =>
    CNPJDaEmpresaLogada = value,
  );

  caixaEBancoJsonLength = await FirebaseFirestore.instance
      .collection('Tenant')
      .doc('4c0356cd-c4f7-4901-b247-63e400d56085')
      .collection('Empresas')
      .doc(CNPJDaEmpresaLogada.toString())
      .collection('CaixaBanco').get().then((value) => value);

  caixaEBancoJson = await FirebaseFirestore.instance
      .collection('Tenant')
      .doc('4c0356cd-c4f7-4901-b247-63e400d56085')
      .collection('Empresas')
      .doc(CNPJDaEmpresaLogada.toString())
      .collection('CaixaBanco').get().then((value) => value.docs);

  double valortotal = 0;
  for(int i = 0; caixaEBancoJsonLength.docs.length > i; i++){
    valortotal = valortotal + caixaEBancoJson[i]['SALDO'];
  }
  return valortotal;
}


// Future<String> BuscandoValorDoProduto(produto) async {
//   final List<TabelaDePreco> valorSimDoProduto = List();
//   for(Map<String, dynamic> element in produto){
//     final TabelaDePreco tabeladepreco = TabelaDePreco(
//       element['Preco'],
//       element['Padrao'],
//       element['Nome'],
//     );
//     valorSimDoProduto.add(tabeladepreco);
//   }
//
//   List<TabelaDePreco> xxx = valorSimDoProduto.where((element) => element.Padrao == 'S').toList();
//   print('TabelaDePreco : ${xxx}');
//   //return nomesEmpresas.toString().replaceAll("[", "").replaceAll("]", "");
// }




