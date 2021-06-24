import 'package:crud_firebase/complements/selectfirebase.dart';
import 'package:crud_firebase/components/alert/alert_small_title_icon.dart';
import 'package:crud_firebase/components/alert/alert_small_troca_empresa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownButtonEmpresas extends StatefulWidget {
  _dropdownButtonEmpresas createState() => _dropdownButtonEmpresas();
}

class _dropdownButtonEmpresas extends State<DropdownButtonEmpresas> {
  get MediaHeight => MediaQuery.of(context).size.height;
  List<String> items = <String>[]; //TODO: Nome da empresa logada
  String selectedEmpresa = ''; //TODO: items do dropdown das empresas

  _dropdownButtonEmpresas() {
    BuscandoNomeEmpresaPadraoDoUsuario().then((valor) => setState(() {
          selectedEmpresa = valor;
        }));
    BuscandoEmpresasDoUsuario().then((valor) => setState(() {
          items = valor;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (selectedEmpresa == null && items == null) {
      return Container(
          child: Center(
              child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
        strokeWidth: 2,
      )));
    }
    return DropdownButton<String>(
      icon: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: const Icon(
          Icons.arrow_drop_down_circle_outlined,
          size: 20,
          color: Colors.white,
        ),
      ),
      underline: Container(
        height: 0,
      ),
      value: selectedEmpresa,
      onChanged: (String string) => setState(() {
        selectedEmpresa = string;
        AlertaTrocaDeEmpresa(context, selectedEmpresa);
      }),
      selectedItemBuilder: (BuildContext context) {
        return items.map<Widget>((String item) {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaHeight / 3.5,
                  child: Center(
                    child: Text(
                      '$item',
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaHeight / 48,
                      ),
                    ),
                  ),
                ),
              ],
            )),
          );
        }).toList();
      },
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaHeight / 3.30,
                    child: Text(
                      '$item',
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: MediaHeight / 50,
                        fontWeight: item.toString() == selectedEmpresa
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black12,
                ),
              )
            ],
          ),
          value: item,
        );
      }).toList(),
    );
  }
}
