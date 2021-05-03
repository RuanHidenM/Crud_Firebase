import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  @override
  _createUserPage createState() => _createUserPage();
}

class _createUserPage extends State<CreateUserPage> {
  GlobalKey<FormState> form = GlobalKey<FormState>();

  var nome = TextEditingController();
  var idade = TextEditingController();

  final List<String> items = <String>['Masculino', 'Feminino', 'Não Informado'];
  String selectedSexo = 'Não Informado';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cria usuario'),
      ),
      body: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
          child: Container(
            height: 350,
            width: double.infinity,
            //color: Colors.blue,
            child: Form(
              key: form,
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                        child: Text(
                          'Nome',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Ex.: Mareia Juliana',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        controller: nome,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                        child: Text(
                          'Idade',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Sua idade',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        controller: idade,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, bottom: 5),
                            child:
                                Text('Sexo: ', style: TextStyle(fontSize: 17)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: DropdownButton<String>(
                                value: selectedSexo,
                                onChanged: (String string) =>
                                    setState(() => selectedSexo = string),
                                selectedItemBuilder: (BuildContext context) {
                                  return items.map<Widget>((String item) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Center(child: Text(item)),
                                    );
                                  }).toList();
                                },
                                items: items.map((String item) {
                                  return DropdownMenuItem<String>(
                                    child: Text('$item'),
                                    value: item,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 60,
                        width: double.infinity,
                        color: Colors.white10,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.red,
                                ),
                              ),
                              FlatButton(
                                onPressed: () async {
                                  if (form.currentState.validate()) {
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .add({
                                          'name': nome.text,
                                          'idade': idade.text,
                                          'sexo': selectedSexo,
                                          'data': Timestamp.now(),
                                        });
                                    Navigator.of(context).pop();
                                  }
                                },
                                child: Text(
                                  'Criar',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
