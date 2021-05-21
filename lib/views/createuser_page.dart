import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/components/alert/alert_small_title_icon.dart';
import 'package:crud_firebase/models/peoplesData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  CreateUserPage({Key key, this.tipo,this.data}): super(key: key);
  String tipo;
  peoplesData data;

  @override
  _createUserPage createState() => _createUserPage();
}

class _createUserPage extends State<CreateUserPage> {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  var _nome = TextEditingController();
  var _idade = TextEditingController();
  List<String> items = <String>['Masculino', 'Feminino', 'Não Informado'];
  String selectedSexo = 'Não Informado';


 void initState(){
   startPage();
 }

  void startPage (){
     if(widget.tipo == 'create'){
        _nome = TextEditingController();
        _idade = TextEditingController();
        selectedSexo = 'Não Informado';
     }
     if(widget.tipo == 'update'){
       _nome.text = widget.data.nome.toString();
       _idade.text = widget.data.idade.toString();
       selectedSexo = widget.data.sexo.toString() == ''
           ? 'Não Informado'
           : widget.data.sexo.toString();
     }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tipo == 'create' ? 'Crair Usuario' : 'Alterar o Usuario'),
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
                        controller: _nome,
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
                        controller: _idade,
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
                                    if(widget.tipo == 'create') {
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .add({
                                        'name': _nome.text,
                                        'idade': _idade.text,
                                        'sexo': selectedSexo,
                                        'data': Timestamp.now(),
                                      });
                                    }

                                    if(widget.tipo == 'update') {//TODO: FALTA FAZER A PARTE DE ALTERAÇÃO DO USUARIO0
                                      await FirebaseFirestore.instance.collection('users').doc(widget.data.id).update({
                                        'name': _nome.text,
                                        'idade': _idade.text,
                                        'sexo': selectedSexo,
                                        'data': Timestamp.now(),
                                      });
                                    }
                                    Navigator.of(context).pop();
                                    AlertaSuccess(context,'Cadastrado', 'Usuario Cadastrado com sucesso',Icons.check);//TODO: msg de usuario cadastrado
                                  }
                                },
                                  child: Text(
                                    widget.tipo == 'create'
                                        ? 'Criar':
                                    widget.tipo == 'update'
                                        ?'Salvar': 'NULL',
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
