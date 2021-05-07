class User{
   String id;
   String nome;
   String idade;
   String sexo;

   User(
      this.id,
      this.nome,
      this.idade,
      this.sexo
      );

  @override
  String toString(){
    return 'User {id: $id, name: $nome, idade: $idade, sexo: $sexo}';
  }
}