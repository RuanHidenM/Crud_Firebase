class TabelaDePreco{
  final double preco;
  final String padrao;
  final String nome;

  TabelaDePreco(
      this.preco,
      this.padrao,
      this.nome
      );

  @override
  String toString(){
    return 'Tabela de Preco {Preco: $preco, Padrão: $padrao, Nome: $nome}';
  }
}