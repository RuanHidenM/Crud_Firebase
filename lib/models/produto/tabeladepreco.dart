class TabelaDePreco{
  final double Preco;
  final String Padrao;
  final String Nome;

  TabelaDePreco(
      this.Preco,
      this.Padrao,
      this.Nome
      );

  @override
  String toString(){
    return 'Tabela de Preco {Preco: $Preco, Padrão: $Padrao, Nome: $Nome}';
  }
}