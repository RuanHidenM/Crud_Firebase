class peoplesData {
   String id;
   String nome;
   String idade;
   String sexo;

   peoplesData (
      this.id,
      this.nome,
      this.idade,
      this.sexo
      );

  @override
  String toString(){
    return 'peoplesData {id: $id, name: $nome, idade: $idade, sexo: $sexo}';
  }
}