import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crud_firebase/models/empresas.dart';

final String userLogadoEmail = FirebaseAuth.instance.currentUser.email.toString();
var dbUsuario = FirebaseFirestore.instance.collection('Usuario');
var empresas = new List<Empresa>();
var empresasJson;

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
  List<Empresa> EmpresaQueForTrue =
  empresas.where((element) => element.logada == true).toList();

  return EmpresaQueForTrue;
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
  String EmpresaPadaoselecionada1 =EmpresaPadaoselecionada.replaceAll("[", "");
  String EmpresaPadaoselecionada2 = EmpresaPadaoselecionada1.replaceAll("]", "");
  return EmpresaPadaoselecionada2;
}