class Empresa{
  final String tenantId;
  final String cnpj;
  final bool logada;
  final String fantasia;

  Empresa(
    this.tenantId,
    this.cnpj,
    this.logada,
    this.fantasia,
  );

  @override
  String toString(){
    return 'Empresas {tenantId:$tenantId, cnpj:$cnpj, logada:$logada,fantasia:$fantasia}';
  }
}


