class Familia{
  final double Codigo;
  final String Id;
  final String Nome;

  Familia(
    this.Codigo,
    this.Id,
    this.Nome
  );

  @override
  String toString(){
    return 'Familia = {Codigo: $Codigo, Id: $Id, Nome: $Nome}';
  }
}