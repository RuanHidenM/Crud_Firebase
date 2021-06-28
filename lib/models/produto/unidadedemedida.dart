class Unidadedemedida{
  final int codigo;
  final String id;
  final String nome;

  Unidadedemedida(
      this.codigo,
      this.id,
      this.nome
      );
  @override
  String toString(){
    return 'Unidadedemedida = {Codigo: $codigo, Id: $id, Nome: $nome}';
  }
}