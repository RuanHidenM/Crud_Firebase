class Modelo{
  final int Codigo;
  final String Id;
  final String Nome;

  Modelo(
      this.Codigo,
      this.Id,
      this.Nome
      );
  @override
  String toString(){
    return 'Modelo = {Codigo: $Codigo, Id: $Id, Nome: $Nome}';
  }
}