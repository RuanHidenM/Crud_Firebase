import 'package:crud_firebase/views/showmodalfiltro.dart';

class Empresa{
  final String tenantId;
  final String cnpj;
  final bool logada;
  final String id;
  final String fantasia;

  Empresa(
    this.tenantId,
    this.cnpj,
    this.logada,
    this.id,
    this.fantasia,
  );

  @override
  String toString(){
    return 'Empresas {tenantId:$tenantId, cnpj:$cnpj, logado:$logada, id:$id, fantasia:$fantasia}';
  }
}


