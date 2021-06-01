import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/components/progress.dart';
import 'package:crud_firebase/firebase/firebase_authentication.dart';
import 'package:crud_firebase/views/drawerside.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ScreenMestreLoadding extends StatefulWidget{
  _screenMestreLoadding createState() => _screenMestreLoadding();
}

class _screenMestreLoadding extends State<ScreenMestreLoadding>{

  get MediaWidth => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Progress(
          message:'Carregando...',
        ),
        ),
      ),
    );
  }
}