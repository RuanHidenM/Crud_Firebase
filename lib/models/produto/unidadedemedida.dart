class Unidadedemedida{
  final int Codigo;
  final String Id;
  final String Nome;

  Unidadedemedida(
      this.Codigo,
      this.Id,
      this.Nome
      );
  @override
  String toString(){
    return 'Unidadedemedida = {Codigo: $Codigo, Id: $Id, Nome: $Nome}';
  }
}