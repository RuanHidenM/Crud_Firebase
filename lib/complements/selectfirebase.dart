import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crud_firebase/models/empresas.dart';
import 'package:firebase_database/firebase_database.dart';

String userLogadoEmail;
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
var tenanteIDDoUsuarioLogado = '';


Future<String> BuscandoEmailDoUsuarioLogado() async {
  //Todo: Buscando o E-MAIL do usuario logado atual
  var retornoDoEmailLogado = await FirebaseAuth.instance.currentUser.email.toString();
  return retornoDoEmailLogado;
}

Future<List<Empresa>> BuscandoEmpresaPadraoDoUsuario() async {
  await BuscandoEmailDoUsuarioLogado().then((value) => userLogadoEmail = value);
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

Future<String> BuscandoTenantIdDoUsuarioLogado() async {
  await BuscandoEmailDoUsuarioLogado().then((value) => userLogadoEmail = value);
  empresasJson = await dbUsuario.doc(userLogadoEmail).get().then((value) => value.data());
 // final List<Empresa> empresas = List();
  var tenanteDaEmpresaLogada;
  for(Map<String, dynamic> element in empresasJson['Empresas']){
    final Empresa empresa = Empresa(
      element['TenantId'],
      element['Cnpj'],
      element['Logada'],
      element['Fantasia'],
    );
    //print(empresa.tenantId);
    if(empresa.logada == true){
        tenanteDaEmpresaLogada = empresa.tenantId;
    }
  }
  //TODO: Buscando apenas os valores que tem tipo do do valor informado.
  //List<Empresa> EmpresaQueForTrue = empresas.where((element) => element.logada == true).toList();
  return tenanteDaEmpresaLogada;

}

Future<String> BuscandoNomeDoUsuario() async {
  await BuscandoEmailDoUsuarioLogado().then((value) => userLogadoEmail = value);
  empresasJson = await dbUsuario.doc(userLogadoEmail).get().then((value) => value.data());
  return empresasJson['Nome'];
}

Future<List<String>> BuscandoEmpresasDoUsuario() async {
  await BuscandoEmailDoUsuarioLogado().then((value) => userLogadoEmail = value);
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
  await BuscandoEmailDoUsuarioLogado().then((value) => userLogadoEmail = value);
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
  await BuscandoEmailDoUsuarioLogado().then((value) => userLogadoEmail = value);
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
 await BuscandoTenantIdDoUsuarioLogado().then((value) =>
 tenanteIDDoUsuarioLogado = value
 );
  caixaEBancoJsonLength = await FirebaseFirestore.instance
      .collection('Tenant')
      .doc(tenanteIDDoUsuarioLogado)
      .collection('Empresas')
      .doc(CNPJDaEmpresaLogada.toString())
      .collection('CaixaBanco').get().then((value) => value);

  caixaEBancoJson = await FirebaseFirestore.instance
      .collection('Tenant')
      .doc(tenanteIDDoUsuarioLogado)
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




