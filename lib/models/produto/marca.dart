class Marca{
  final int codigo;
  final String id;
  final String nome;

  Marca(
      this.codigo,
      this.id,
      this.nome
      );
  @override
  String toString(){
    return 'Marca = {Codigo: $codigo, Id: $id, Nome: $nome}';
  }
}