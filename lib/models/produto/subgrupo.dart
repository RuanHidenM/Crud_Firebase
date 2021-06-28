class Subgrupo{
  final int codigo;
  final String id;
  final String nome;

  Subgrupo(
      this.codigo,
      this.id,
      this.nome
      );
  @override
  String toString(){
    return 'Subgrupo = {Codigo: $codigo, Id: $id, Nome: $nome}';
  }
}