
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/complements/buscandoempresadousuario.dart';
import 'package:crud_firebase/views/drawerside.dart';
import 'package:crud_firebase/views/screen_erro_login.dart';
import 'package:crud_firebase/views/screen_mestre_loadding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  _homePage createState() => _homePage();
}

class _homePage extends State<HomePage>{
  get MediaWidth => MediaQuery.of(context).size.width;
  var snapshots;
  String EmailIdentificado;
  var resultado;
  var Empresas2;
  //var empresas = new List<Empresa>();
  final String userLogadoEmail = FirebaseAuth.instance.currentUser.email.toString();
  var dbUsuario = FirebaseFirestore.instance.collection('Usuario');


  void initState(){
    super.initState();
    setState(() {
        VerificaEmailLogadoComEmailCadastrado(userLogadoEmail);
         //snapshots = dbUsuario.where('Email', isEqualTo: userLogadoEmail).snapshots();
         snapshots = dbUsuario.snapshots();
        //BuscandoEmpresaPadraoDoUsuario().then((empresas) => print('Lista de empresas $empresas'));
       // BuscandoEmpresasDoUsuario().then((nomesEmpresas) => print('nomes de empresas $nomesEmpresas'));
    });
  }


  @override
  void VerificaEmailLogadoComEmailCadastrado(String userLogadoEmail) async {
    var resultado = await dbUsuario.doc(userLogadoEmail).get().then((value) => value.data());
    resultado == null ? EmailIdentificado = 'invalido': EmailIdentificado = 'valido';
    setState(() {
      EmailIdentificado;
    });
  }

  Widget build(BuildContext context) {
    if(EmailIdentificado != 'valido' && EmailIdentificado != 'invalido'){//Todo: se não for processado ainda, mostrar tela de carregamento
      return ScreenMestreLoadding();
    }
    if(EmailIdentificado == 'valido'){//TODO: Se o usuario for verificado, ele ira se manter nessa tela !!
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
                      return Center(child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),));
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


