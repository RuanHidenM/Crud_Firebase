class Modelo{
  final int codigo;
  final String id;
  final String nome;

  Modelo(
      this.codigo,
      this.id,
      this.nome
      );
  @override
  String toString(){
    return 'Modelo = {Codigo: $codigo, Id: $id, Nome: $nome}';
  }
}