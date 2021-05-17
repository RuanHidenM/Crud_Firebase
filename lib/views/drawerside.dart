import 'package:crud_firebase/components/button/circular_button_big_title_color_icon.dart';
import 'package:crud_firebase/components/button/circular_button_small_title_color_icon.dart';
import 'package:crud_firebase/firebase/firebase_authentication.dart';
import 'package:crud_firebase/views/createuser_page.dart';
import 'package:crud_firebase/views/showmodalfiltro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerSide extends StatelessWidget {

  var userLogado = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircularButtonBiglTitleColorIcon(
                          corDoIcon: Colors.white,
                          corDobotao: Colors.black,
                          iconDoBotao: Icons.person
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 5),
                    child: Container(
                      color: Colors.white30,
                      width: 190,
                      height: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ruan Heiden', style: TextStyle(color: Colors.white),),
                          Text('${userLogado.email.toString()}', style: TextStyle(fontSize: 15, color: Colors.white),),
                          Text('RH - SISTEMAS LTDA', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text('teste'),
                ],
              ),
            ],),
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filtrar'),
                CircularButtonSmallTitleColorIcon(
                    iconDoBotao: Icons.search,
                    corDobotao: Colors.white,
                    corDoIcon: Colors.orange
                )
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(child: ShowModalFiltro());
                  }
              );

            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Criar Usuario'),
                CircularButtonSmallTitleColorIcon(
                  iconDoBotao: Icons.person_add,
                  corDoIcon: Colors.green,
                  corDobotao:Colors.white
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateUserPage(tipo: 'create')));
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Suporte'),
                CircularButtonSmallTitleColorIcon(
                    iconDoBotao: Icons.help_outline_outlined,
                    corDobotao: Colors.white,
                    corDoIcon: Colors.blue
                )
              ],
            ),
            onTap: () { },
          ),
          Container(
            color: Colors.red[400],
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Desconectar', style: TextStyle(fontSize: 15, color: Colors.white),),
                  CircularButtonSmallTitleColorIcon(
                    iconDoBotao: Icons.logout,
                    corDoIcon: Colors.red,
                    corDobotao: Colors.white
                  )
                ],
              ),
              onTap: () {
                context.read<AuthenticationService>().signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
