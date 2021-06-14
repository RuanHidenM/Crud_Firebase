class Subgrupo{
  final int Codigo;
  final String Id;
  final String Nome;

  Subgrupo(
      this.Codigo,
      this.Id,
      this.Nome
      );
  @override
  String toString(){
    return 'Subgrupo = {Codigo: $Codigo, Id: $Id, Nome: $Nome}';
  }
}