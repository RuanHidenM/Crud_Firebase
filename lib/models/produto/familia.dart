class Familia{
  final double codigo;
  final String id;
  final String nome;

  Familia(
    this.codigo,
    this.id,
    this.nome
  );

  @override
  String toString(){
    return 'Familia = {Codigo: $codigo, Id: $id, Nome: $nome}';
  }
}