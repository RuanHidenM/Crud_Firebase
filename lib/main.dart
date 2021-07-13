
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/firebase/firebase_authentication.dart';
import 'package:crud_firebase/models/empresas.dart';
import 'package:crud_firebase/views/home.dart';
import 'package:crud_firebase/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MyApp(),
  );
}

//TODO: CRUD Basico para testar o firebase, Imprimindo, criando, editando, excluindo.
class MyApp extends StatelessWidget {
  final Empresa empresa;
  MyApp({this.empresa});

  FirebaseDatabase database;
  @override
  Widget build(BuildContext context) {
    //TODO Declarando que o sistema off-line do firebase deve ser ativado
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    //TODO Declarando que o tamanho do cache deve ser de '200000000'.
    database.setPersistenceCacheSizeBytes(5000000000);
    //TODO Declarando que o descarte do cache mais antigo esta desativado
    //FirebaseFirestore.instance.settings = Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

    ///Todo Limpando todo o cache do firestore, até esse momento
    //FirebaseFirestore.instance.clearPersistence();

    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges, initialData: null,
        )
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        home: AuthenticationWrapper(),
      ),
    );
  }
}
class AuthenticationWrapper extends StatefulWidget{
  _authenticationWrapper createState() => _authenticationWrapper();
}

class _authenticationWrapper extends State<AuthenticationWrapper> {

  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
        return HomePage();
    }
    return LoginPage();
  }
}
