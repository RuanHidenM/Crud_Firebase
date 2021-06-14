class Grupo{
  final int Codigo;
  final String Id;
  final String Nome;

  Grupo(
      this.Codigo,
      this.Id,
      this.Nome
      );
  @override
  String toString(){
    return 'Grupo = {Codigo: $Codigo, Id: $Id, Nome: $Nome}';
  }
}