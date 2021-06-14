class Marca{
  final int Codigo;
  final String Id;
  final String Nome;

  Marca(
      this.Codigo,
      this.Id,
      this.Nome
      );
  @override
  String toString(){
    return 'Marca = {Codigo: $Codigo, Id: $Id, Nome: $Nome}';
  }
}