import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/models/empresas.dart';
import 'package:crud_firebase/views/drawerside.dart';
import 'package:crud_firebase/views/scree_erro_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget{
  _homePage createState() => _homePage();
}

class _homePage extends State<HomePage>{
  get MediaWidth => MediaQuery.of(context).size.width;
  var snapshots;
  var snapshots2;
  bool EmailIdentificado;
  var resultado;
  var db = FirebaseFirestore.instance;
  var x;
  var empresas = new List<Empresa>();

  void initState(){
    super.initState();

    setState(() {
        var userLogadoEmail = FirebaseAuth.instance.currentUser == null ? '': FirebaseAuth.instance.currentUser.email;
        VerificaEmailLogadoComEmailCadastrado(userLogadoEmail);
        snapshots = db.collection('Usuario').where('Email', isEqualTo: userLogadoEmail).snapshots();
       BuscandoEmpresasDoUsuario();
    });
  }

  void BuscandoEmpresasDoUsuario(){

    snapshots2 = db.collection('Usuario');
      snapshots2.get().then((value) async {
        value.docs.forEach((element) {
         // print(element['Empresas']);
            x = element['Empresas'];
           // print(x);
      });
       //  x.then((response){
       //   Iterable lista = json.decode(response.body);
       //   empresas = lista.map((model) => Empresa.fromJson(model)).toList();
       // });
       //
       //  final List<dynamic> decodeJson = jsonDecode(x.body);
       //  final List<Empresa> empresa = List();
       //
       //
       //  for(Map<String, dynamic> element in decodeJson){
       //    final Empresa empresas = Empresa(
       //      element['tenantId'],
       //      element['cnpj'],
       //      element['logada'],
       //      element['id'],
       //      element['fantasia'],
       //    );
       //    print('teste : ${empresas.toString()}');
       //    empresa.add(empresas);
       //  }

      });
}

  @override
  void VerificaEmailLogadoComEmailCadastrado(String userLogadoEmail) async {
    resultado = await FirebaseFirestore.instance.collection('Usuario').where('Email', isEqualTo: userLogadoEmail).get();
      resultado.docs.isEmpty ? EmailIdentificado = false: EmailIdentificado = true;
      setState(() {
        EmailIdentificado;
      });
  }


  Widget build(BuildContext context) {
    if(EmailIdentificado == true){//TODO: Se o usuario for verificado, ele ira se manter nessa tela !!
      return Scaffold(
        drawer:DrawerSide(),
        appBar: AppBar(
          shadowColor: Color.fromRGBO(36, 82, 108, 250),
          //Todo: cor da borda shadow, para ficar mesclado com o widget de filtro a baixo
          backgroundColor: Color.fromRGBO(36, 82, 108, 25),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Home', style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
                child: StreamBuilder(
                  stream:  snapshots,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot,
                  ){
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.data.docs.length == 0) {
                      return Center(child: Text('Nenhum Caixas e Bancos Cadastrado!!'));
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int i) {
                        var users = snapshot.data.docs[i];
                        return Column(
                          children: [
                            Text(users['Email']),
                            //Text(users['Empresas'].toString()),
                            Text(users['Empresas'].toString()),
                          ],
                        );
                      },
                    );
                  },
                )
            )
          ],
        ),
      );
    }else{//Todo: Se o E-mail logado não for encontrado no banco, retornara uma tela erro.
      return ErroNoLogin();
    }
  }
}


