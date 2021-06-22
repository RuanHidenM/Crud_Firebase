
import 'package:crud_firebase/firebase/firebase_authentication.dart';
import 'package:crud_firebase/models/empresas.dart';
import 'package:crud_firebase/views/home.dart';
import 'package:crud_firebase/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MyApp()
  );
}

//TODO: CRUD Basico para testar o firebase, Imprimindo, criando, editando, excluindo.
class MyApp extends StatelessWidget {
  final Empresa empresa;
  MyApp({this.empresa});

  @override
  Widget build(BuildContext context) {
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
      print('--HomePage: $firebaseUser');
        return HomePage();
    }
    print('-- LoginPage: $firebaseUser');
    return LoginPage();
  }
}