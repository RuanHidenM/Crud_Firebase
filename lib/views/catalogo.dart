import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/components/mytextfield.dart';
import 'package:crud_firebase/views/detalhesdoitem.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Catalogo extends StatefulWidget {
  @override
  _catalogo createState() => _catalogo();
}

class _catalogo extends State<Catalogo> {
  static String tag = '/catalogo';

  //var user = Firebase.auth().currentUser;

  //var dbUsuario = FirebaseFirestore.instance.collection('Usuario').doc('Empresas');
  var userLogado = FirebaseAuth.instance.currentUser;
  var snapshots;
  var snapshots2;
  var empresasJson;

  _catalogo() {
    BuscandoProdutosDoUsuario();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      snapshots = FirebaseFirestore.instance.collection('produto').snapshots();
      //empresasJson = dbUsuario.doc(userLogadoEmail).get().then((value) => value.data());
    });
  }

  Future<List<String>> BuscandoProdutosDoUsuario() async {

    snapshots2 = await FirebaseFirestore.instance
        .collection('Tenant')
        .doc('4c0356cd-c4f7-4901-b247-63e400d56085')
        .collection('Empresas')
        .doc('01747426000176')
        .collection('Produtos')
        .doc('3b5f02d1-95d6-4671-94b8-0d1c63438838')
        .get().then((value) => value.data());
    print('retorno dos produtos : $snapshots2');
  }

  Widget build(BuildContext context) {
    //print(userLogado.email.toString()); //TODO:Pegando o usuario já logado
    // var snapshots = FirebaseFirestore.instance
    //     .collection('users')
    //     .orderBy('data')
    //     .snapshots(); //TODO: Buscar a banco 'USERS' e ordenar com base na 'DATA'
    //var snapshots = FirebaseFirestore.instance.collection('users').snapshots();//TODO: BUSCANDO UM USUARIO

    testandoalgumacoisa();
    return Scaffold(
      //drawer:DrawerSide(),
      appBar: AppBar(
        shadowColor: Color.fromRGBO(36, 82, 108, 250),
        //Todo: cor da borda shadow, para ficar mesclado com o widget de filtro a baixo
        backgroundColor: Color.fromRGBO(36, 82, 108, 25),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Catálogo',
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Icon(Icons.filter_list_rounded,
                  color: Colors.white, size: 25),
            ),
          ],
        ),

        // Text('Produtos', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  color: Color.fromRGBO(36, 82, 108, 25),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      //TODO: SAFE
                      Expanded(
                        flex: 3,
                        child: Container(
                          //color:Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    Container(
                                      width: 250,
                                      height: 55,
                                      child: myTextField(
                                        titleName: 'Buscar Produtos',
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.qr_code_scanner,
                                  color: Colors.white,
                                  size: 25,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
          ),
          Expanded(
            flex: 9,
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
                  return Center(child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),));
                }
                if (snapshot.data.docs.length == 0) {
                  return Center(child: Text('Nenhum usuario Cadastrado!!'));
                }

                //TODO: Lista dos usuarios cadastrados.
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      var produtos = snapshot.data.docs[i];
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, right: 5, left: 5),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: const Offset(
                                    1.0,
                                    1.0,
                                  ),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 3,
                                          child: Container(
                                            height: 100,
                                            //color: Colors.yellow,
                                            child: Center(
                                              child: ClipRRect(
                                                child: Image.asset(produtos['nome'] == 'Achocolatado Po Nescau 2.0' ? 'images/nescal.png' :
                                                produtos['nome'] == 'Biscoito Recheado com creme' ? 'images/bolacha.png' : 'images/achocolatado.png'),
                                              ),
                                            ),
                                          )),
                                      Expanded(
                                          flex: 7,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                    height: MediaQuery.of(context).size.height/ 11,
                                                    //color:Colors.red,
                                                    child: Column(
                                                      children: [
                                                        Flexible(
                                                            child: Text(
                                                              '${produtos['nome']}',
                                                              overflow: TextOverflow.ellipsis,
                                                              style: TextStyle(fontSize: MediaQuery.of(context).size.height/ 40,),
                                                            ),
                                                        ),
                                                      ],
                                                    )
                                                ),
                                                Container(
                                                    //color:Colors.blue,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(right: 5),
                                                              child: Icon(Icons.monetization_on, color: Colors.green, size: MediaQuery.of(context).size.height/ 40,),
                                                            ),
                                                            Text('R\$: ', style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.height/ 50),),
                                                            Text('${produtos['valor'].toStringAsFixed(2).toString().replaceAll('.', ',')}', style: TextStyle( fontSize: MediaQuery.of(context).size.height/ 40),),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text('Estoque: ', style: TextStyle(color: Colors.grey, fontSize: MediaQuery.of(context).size.height/ 50),),
                                                            Text('${produtos['un']}'),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                ),
                                              ],
                                            ),
                                          ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        onDoubleTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetalhesDoItem(
                            nome: produtos['nome'],
                            descricao: produtos['descicao'],
                            un: produtos['un'],
                            valor: produtos['valor'],
                          )));
                        },
                      );
                    });
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => CreateUserPage(
      //                 tipo:
      //                 'create'))); //TODO: Navegando para a tela de criar usuario.
      //   },
      //   tooltip: 'Adicionar um novo usuario.',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<void> testandoalgumacoisa() async {
  var db = FirebaseFirestore.instance;
  QuerySnapshot resultado = await db.collection('Usuario').where('Email', isEqualTo: 'usuteste@emporiofloriano.com.br').get();
  resultado.docs.forEach((d){
    // print('Email :${d['Email']}');
    // print('Empresas: ${d['Empresas']}');
    // print('id: ${d['Id']}');
    // print('Nome ${d['Nome']}');
  });
}

// FirebaseFiltrando([String nome, String idadeMax, String idadeMin, String selectedSexo]){
//   print('nome: $nome, IdadeMax: $idadeMin, IdadeMin: $idadeMax, Sexo: $selectedSexo');
//   print('ta na funcão');
//
//
//   if(nome != '' && nome != null){
//     print('Entro no filtro, nome informado : $nome');
//     return FirebaseFirestore.instance.collection('users').where('name', isEqualTo: nome).snapshots();
//   }else{
//    print('Sem fitlro');
//     return FirebaseFirestore.instance.collection('users').snapshots();
//   }
// }
