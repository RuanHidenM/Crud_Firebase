import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String tag = '/home';

  @override
  Widget build(BuildContext context) {
    var snapshots = FirebaseFirestore.instance.collection('users').orderBy('data').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Firebase'),
      ),
      backgroundColor: Colors.grey[200],
      body: StreamBuilder(
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

          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int i) {
                var doc = snapshot.data.docs[i];
                var user = doc.data();
                return Container(
                  decoration: BoxDecoration(

                    color:Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                  child:  ListTile(
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
                      onPressed: (){
                       //user['sexo'] == 'Feminino' ? doc.reference.update({'sexo' : 'Masculino'}):
                            if(user['sexo'] == 'Masculino'){
                              doc.reference.update({'sexo' : 'Feminino'});
                            }
                            if(user['sexo'] == 'Feminino'){
                              doc.reference.update({'sexo' : ''});
                            }
                            if(user['sexo'] == ''){
                              doc.reference.update({'sexo' : 'Masculino'});
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
                    )
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          modalCreate(context);
        },
        tooltip: 'Adicionar um novo usuario.',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  modalCreate(BuildContext context){
    GlobalKey<FormState> form = GlobalKey<FormState>();

    var nome = TextEditingController();
    var idade = TextEditingController();
    var sexo = TextEditingController();

    bool _isChecked = false;

    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Cadastro de usuario'),
            content: Form(
              key: form,

              child:Container(
                height: MediaQuery.of(context).size.height / 3,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(' Nome '),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Ex.: Mareia Juliana',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      controller: nome,
                      validator: (value){
                        if(value.isEmpty){
                          return 'Este campo não pode ser vazio !';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    Text(' Idade '),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Sua idade',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      controller: idade,
                      validator: (value){
                        if(value.isEmpty){
                          return 'Este campo não pode ser vazio !';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     hintText: 'Sua idade',
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(0),
                    //     ),
                    //   ),
                    //   controller: sexo,
                    //   // validator: (value){
                    //   //   if(value.isEmpty){
                    //   //     return 'Este campo não pode ser vazio !';
                    //   //   }
                    //   //   return null;
                    //   // },
                    // )
                  ],
                ),

              ),


            ),
            actions: [
              //TODO: Botão fechar AlertDialog.
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancelar'),
                  color: Colors.red
              ),
              //TODO: Botão salvar cadatro.
              FlatButton(
                onPressed: () async {
                  if(form.currentState.validate()){
                    await FirebaseFirestore.instance.collection('users').add({
                      'name': nome.text,
                      'idade':idade.text,
                      'sexo':'',
                      'data': Timestamp.now(),
                    });

                    Navigator.of(context).pop();
                  }
                },
                child: Text('Salvar'),
                color: Colors.green,
              )
            ],
          );
        }
    );
  }

}
