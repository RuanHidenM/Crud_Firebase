class Grupo{
  final int codigo;
  final String id;
  final String nome;

  Grupo(
      this.codigo,
      this.id,
      this.nome
      );
  @override
  String toString(){
    return 'Grupo = {Codigo: $codigo, Id: $id, Nome: $nome}';
  }
}