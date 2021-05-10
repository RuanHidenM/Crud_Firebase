import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/models/peoplesData.dart';
import 'package:crud_firebase/views/createuser_page.dart';
import 'package:crud_firebase/views/drawerside.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  static String tag = '/home';

  //var user = Firebase.auth().currentUser;
  var userLogado = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    //print(userLogado.email.toString()); //TODO:Pegando o usuario já logado

    var snapshots = FirebaseFirestore.instance
        .collection('users')
        .orderBy('data')
        .snapshots(); //TODO: Buscar a banco 'USERS' e ordenar com base na 'DATA'
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Firebase', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.grey[200],
        drawer:DrawerSide(),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: StreamBuilder(
              stream: snapshots,
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.data.docs.length == 0) {
                  return Center(child: Text('Nenhum usuario Cadastrado!!'));
                }

                //TODO: Lista dos usuarios cadastrados.
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      var doc = snapshot.data.docs[i];
                      var user = doc;
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                          child: ListTile(
                              isThreeLine: true,
                              leading: IconButton(
                                icon: Icon(
                                  Icons.person,
                                  color: user['sexo'] == 'Masculino'
                                      ? Colors.blue
                                      : user['sexo'] == 'Feminino'
                                          ? Colors.pink
                                          : Colors.black,
                                  size: 32,
                                ),
                                onPressed: () {
                                  //user['sexo'] == 'Feminino' ? doc.reference.update({'sexo' : 'Masculino'}):
                                  if (user['sexo'] == 'Masculino') {
                                    //TODO; Se o selecionado é Masculino, vira Feminino
                                    doc.reference.update({'sexo': 'Feminino'});
                                  }
                                  if (user['sexo'] == 'Feminino') {
                                    //TODO: Se o selecionado é Feminino, vira '', não informado
                                    doc.reference.update({'sexo': ''});
                                  }
                                  if (user['sexo'] == '') {
                                    //TODO: Se o selecionado é '', vira Masculino.
                                    doc.reference.update({'sexo': 'Masculino'});
                                  }
                                },
                              ),
                              title: Text(user['name']),
                              subtitle: Text(user['idade'].toString()),
                              trailing: CircleAvatar(
                                backgroundColor: Colors.red[400],
                                foregroundColor: Colors.white,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    //color: Colors.red,
                                  ),
                                  onPressed: () {
                                    doc.reference.delete();
                                    //users.doc('aOPLvaEXftwFWIfzdziv').delete();
                                    //doc.reference.update('')
                                  },
                                ),
                              )),
                        ),
                        onDoubleTap: () {
                          peoplesData DadosUsers = peoplesData(doc.id,
                              user['name'], user['idade'], user['sexo']);
                          //print(DadosUsers.toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateUserPage(
                                      tipo: 'update', data: DadosUsers)));
                        },
                      );
                    });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateUserPage(
                      tipo:
                          'create'))); //TODO: Navegando para a tela de criar usuario.
        },
        tooltip: 'Adicionar um novo usuario.',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
