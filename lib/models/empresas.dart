import 'package:crud_firebase/views/showmodalfiltro.dart';

class Empresa{
  String tenantId;
  String cnpj;
  bool logada;
  String id;
  String fantasia;

  Empresa(String cnpj, String fantasia, String id, bool logada, String tenantId){
    this.tenantId = tenantId;
    this.cnpj = cnpj;
    this.logada = logada;
    this.id = id;
    this.fantasia = fantasia;
  }

  @override
  String toString(){
    return 'Empresas {tenantId: $tenantId, cnpj: $cnpj,  logado: $logada, id: $id,fantasia: $fantasia }';
  }

  Empresa.fromJson(Map json):
    tenantId = json['tenantId'],
    cnpj = json['cnpj'],
    logada = json['logada'],
    id = json['id'],
    fantasia = json['fantasia'];
}