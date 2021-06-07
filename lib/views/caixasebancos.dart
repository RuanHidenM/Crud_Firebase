import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CaixaEBanco extends StatefulWidget {
  @override
  _caixasEBancos createState() => _caixasEBancos();
}

class _caixasEBancos extends State<CaixaEBanco> {
  get MediaWidget => MediaQuery.of(context).size.height;
  var snapshots;

  @override
  void initState() {
    super.initState();
    setState(() {
      snapshots =
          FirebaseFirestore.instance.collection('CaixasBancos').where('Codigo', isEqualTo: 920).snapshots();
    });
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          shadowColor: Color.fromRGBO(36, 82, 108, 250),
          //Todo: cor da borda shadow, para ficar mesclado com o widget de filtro a baixo
          backgroundColor: Color.fromRGBO(36, 82, 108, 25),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Caixas e Bancos',
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
                      return Center(child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),));
                    }
                    if (snapshot.data.docs.length == 0) {
                      return Center(child: Text('Nenhum Caixas e Bancos Cadastrado!!'));
                    }

                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int i) {
                        var caixasebancos = snapshot.data.docs[i];
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, right: 5, left: 5),
                            child: Container(
                              height: MediaWidget / 6,
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
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 90,
                                              // color: Colors.yellow,
                                              child: Center(
                                                // child: Icon(Icons.apartment),//banco
                                                child: Icon(
                                                  caixasebancos['Tipo'] == 1
                                                      ? Icons
                                                          .move_to_inbox_rounded
                                                      : Icons.apartment,
                                                  size: MediaWidget / 20,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            )),
                                        Expanded(
                                            flex: 7,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Container(
                                                      height:
                                                          MediaQuery.of(context).size.height / 15,
                                                      //color:Colors.red,
                                                      child: Text(
                                                        '${caixasebancos['Nome']}',

                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontSize: MediaQuery.of(context).size.height / 43,
                                                        ),
                                                      )),
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
                                                            child: Icon(
                                                              Icons.monetization_on,
                                                              color: caixasebancos['Saldo'] > 0 ? Colors.green : Colors.red,
                                                              size: MediaQuery.of(context).size.height /42,
                                                            ),
                                                          ),
                                                          Text('R\$: ',
                                                            style: TextStyle(
                                                                color: Colors.grey,
                                                                fontSize: MediaQuery.of(context).size.height / 50),
                                                          ),
                                                          Text(
                                                            '${caixasebancos['Saldo']}',
                                                            style: TextStyle(fontSize: MediaQuery.of(context).size.height /42),
                                                          ),

                                                        ],
                                                      ),
                                                    ],
                                                  )),
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
                          onDoubleTap: () {},
                        );
                      },
                    );
                  },
                ),
            ),
          ],
        ),
    );
  }
}
