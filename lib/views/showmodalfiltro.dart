import 'package:crud_firebase/components/button/button_average_title_icon_color.dart';
import 'package:crud_firebase/components/button/button_small_title_icon_color.dart';
import 'package:crud_firebase/components/mytextfield.dart';
import 'package:crud_firebase/views/catalogo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowModalFiltro extends StatefulWidget {
  @override
  _showModalFiltro createState() => _showModalFiltro();
}

class _showModalFiltro extends State<ShowModalFiltro> {
  List<String> items = <String>['Masculino', 'Feminino', 'Não Informado'];
  String selectedSexo = 'Não Informado';

  final _nomeController = TextEditingController();
  final _idadeMinController = TextEditingController();
  final _idadeMaxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 340,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    width: double.infinity,
                    color: Colors.orangeAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Buscar Usuario',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(
                            Icons.person_search,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ],
                    )),
              ),
              Expanded(
                flex: 12,
                child: Container(
                  // color: Colors.grey[200],
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          height: 67,
                          width: MediaQuery.of(context).size.width,
                          child: myTextField(
                              titleName: 'Nome',
                              descriptionName: 'Infome um nome',
                              typeKeyBoard: TextInputType.name,
                              nomeDoComtrolador: _nomeController,
                              colorTextField:
                                  Color.fromRGBO(155, 155, 155, 210)),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 67,
                                width: MediaQuery.of(context).size.width,
                                child: myTextField(
                                    titleName: 'Idade minima',
                                    descriptionName: 'Infome a idade minina',
                                    typeKeyBoard: TextInputType.number,
                                    nomeDoComtrolador: _idadeMinController,
                                    colorTextField:
                                        Color.fromRGBO(155, 155, 155, 210)),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  'Até',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 67,
                                width: MediaQuery.of(context).size.width,
                                child: myTextField(
                                    titleName: 'Idade maxima',
                                    descriptionName: 'Infome a idade maxima',
                                    typeKeyBoard: TextInputType.number,
                                    nomeDoComtrolador: _idadeMaxController,
                                    colorTextField:
                                        Color.fromRGBO(155, 155, 155, 210)),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.all(
                                Radius.circular(80),
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 25.0,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    'Sexo: ',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.black45),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35),
                                  child: Container(
                                    child: DropdownButton<String>(
                                      value: selectedSexo,
                                      onChanged: (String string) =>
                                          setState(() => selectedSexo = string),
                                      selectedItemBuilder:
                                          (BuildContext context) {
                                        return items.map<Widget>((String item) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Center(child: Text(item)),
                                          );
                                        }).toList();
                                      },
                                      items: items.map((String item) {
                                        return DropdownMenuItem<String>(
                                          child: Text('$item'),
                                          value: item,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  //color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: Container(
                          child: buttonSmallTitleIconColor(
                            name: 'Limpar',
                            corDoTexto: Colors.white,
                            corDoBotao: Colors.orange,
                            iconDoButton: Icons.clear_all,
                            corDoIcon: Colors.white,
                          ),
                        ),
                        onTap: () {
                          LimpaFiltro();
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          child: buttonAverageTitleIconColor(
                            name: 'Buscar',
                            corDoTexto: Colors.white,
                            corDoBotao: Colors.green,
                            iconDoButton: Icons.search,
                            corDoIcon: Colors.white,
                          ),
                        ),
                        onTap: () {
                          // print(_nomeController.text.toString());
                          // print(_idadeMinController.text.toString());
                          // print(_idadeMaxController.text.toString());
                          // print(selectedSexo.toString());

                          setState(() {
                            Catalogo();
                            //FirebaseFiltrando(nome, idademax, idademin, selectedSexo);
                          });
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LimpaFiltro() {
    setState(() {
      _nomeController.text = '';
      _idadeMaxController.text = '';
      _idadeMinController.text = '';
      selectedSexo = 'Não Informado';
    });
  }
}
