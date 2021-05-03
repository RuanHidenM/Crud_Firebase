
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/views/homepage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // users.get().then((value){
    //   value.docs.forEach((element){
    //     print(element.data());
    //   });
    // });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange,),
      initialRoute:HomePage.tag,
      routes: {
        HomePage.tag:(context) => HomePage()
      },
    );
  }
}



// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   runApp(GetUserName('9IhswW3v9IVFgrIypDU2'));
//
// }

//class GetUserName extends StatelessWidget {
//   final String documentId;
//
//   GetUserName(this.documentId);
//
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');
//
//     //TODO: Retornado todos os dados do firestore, e imprimindo no console
//     users.get().then((value){
//       value.docs.forEach((element) {
//         print(element.data()['idade']);
//       });
//     });
//
//     //TODO: Adicionando um usuario.
//     // users.add({
//     //   "name":"Maria",
//     //   "idade":23
//     // });
//
//     //TODO: Alterando um json, adicinando mais uma chave valor.
//     //users.doc('e2FjeldJQM2IsK3E00YO').update({'descrição': 'Criando uma descrição'});
//
//     //TODO: Se o a chave já for criada, ele só vai alterar o valor apontada para a chavedefinida
//     //users.doc('e2FjeldJQM2IsK3E00YO').update({'name': 'dale'});
//
//     //TODO: Deletando um usuario, apontando seu id
//     //users.doc('aOPLvaEXftwFWIfzdziv').delete();
//
//
//
//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(documentId).get(),
//       builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//
//         if (snapshot.hasError) {
//           return Text("Something went wrong", textDirection: TextDirection.ltr,);
//         }
//
//         if (snapshot.hasData && !snapshot.data.exists) {
//           return Text("Document does not exist", textDirection: TextDirection.ltr,);
//         }
//
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data.data();
//           return Text("Full Name: ${data['name']} phone number :${data['idade']}", textDirection: TextDirection.ltr,);
//         }
//
//         return Text("loading", textDirection: TextDirection.ltr,);
//       },
//     );
//   }
// }