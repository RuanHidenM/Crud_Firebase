// import 'package:flutter/material.dart';
// import 'package:listandoapimestre/components/formbuscacaixabanco.dart';
//
// class PesquisaTopBar extends StatefulWidget {
//   PesquisaTopBar(this.tipocaixaoubanco);
//   final double tipocaixaoubanco;
//
//
//   @override
//   _PesquisaTopBarState createState() => _PesquisaTopBarState();
// }
//
// class _PesquisaTopBarState extends State<PesquisaTopBar> {
//
//   @override
//   Widget build(BuildContext context) {
//     return
//     //   Container(
//     //   height: 37,
//     //   width: 37,
//     //   decoration: BoxDecoration(
//     //       color: Colors.orange,
//     //       borderRadius: BorderRadius.all(
//     //         Radius.circular(90),
//     //       )
//     //   ),
//     //   child: IconButton(
//     //     icon: Icon(Icons.search, color: Colors.white),
//     //     onPressed: () {
//     //       showModalBottomSheet<void>(
//     //           context: context,
//     //           isScrollControlled: true,
//     //           builder: (BuildContext context) {
//     //             return SingleChildScrollView(
//     //               padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//     //               child: Container(
//     //                 //height: 360,
//     //                 color: Colors.white,
//     //                 child: Column(
//     //                     children: [
//     //                       Container(
//     //                           decoration: BoxDecoration(
//     //                             border: Border(
//     //                               bottom: BorderSide(
//     //                                 color: Colors.black26,
//     //                                 width: 1.0,
//     //                               ),
//     //                             ),
//     //                           ),
//     //                           height: 45,
//     //                           width: double.maxFinite,
//     //                           child: Padding(
//     //                             padding: const EdgeInsets.only(top: 9, left: 10),
//     //                             child: Column(
//     //                               children: [
//     //                                 Row(
//     //                                   mainAxisAlignment: MainAxisAlignment.center,
//     //                                   children: [
//     //                                     Padding(
//     //                                       padding: const EdgeInsets.only(left: 8, right: 8),
//     //                                       child: widget.tipocaixaoubanco == 1
//     //                                           ? Icon(Icons.move_to_inbox_outlined,size: 27, color: Colors.orange,)//Todo: Se o valor informado for igual a 1
//     //                                           : Icon(Icons.account_balance_outlined,size: 27, color: Colors.orange,),//Todo: Se o valor for diferente d 1
//     //                                     ),
//     //                                     Text(
//     //                                       widget.tipocaixaoubanco == 1 ? 'Filtrar Caixas' : 'Filtrar Bancos',
//     //                                       style: TextStyle(
//     //                                         fontSize: 20,
//     //                                       ),
//     //                                     ),
//     //                                   ],
//     //                                 ),
//     //                               ],
//     //                             ),
//     //                           )
//     //                       ),//Todo: Title do filtro
//     //                       Padding(
//     //                         padding: const EdgeInsets.only(left:18, right: 18),
//     //                         child: Column(
//     //                           children: [
//     //                             Container(
//     //                               height: 250,
//     //                               width: MediaQuery.of(context).size.width,
//     //                               //color: Colors.blue,
//     //                               child: Column(
//     //                                 children: [
//     //                                   Flexible(
//     //                                     child: Container(
//     //                                       width: double.maxFinite,
//     //                                       child: myTextField(
//     //                                         titleName: 'Empresa',
//     //                                         descriptionName: 'Informe o nome da empresa',
//     //                                         changeTypeName: (text){filtraCaixaeBanco.name = text.toString();},
//     //                                         nomeDoComtrolador: _nameController,
//     //                                         typeKeyBoard: TextInputType.name,
//     //                                         TextTipeMask: null,
//     //                                         colorTextField: Color.fromRGBO(170, 170, 170, 200),
//     //                                       ),
//     //                                     ),
//     //                                   ),
//     //                                   Flexible(
//     //                                     child: Container(
//     //                                       width: double.maxFinite,
//     //                                       child: myTextField(
//     //                                         titleName: 'CNPJ',
//     //                                         descriptionName: 'Informe o CNPJ da empresa',
//     //                                         changeTypeName: (text){filtraCaixaeBanco.cnpjempresa = text;},
//     //                                         nomeDoComtrolador: _cnpjController,
//     //                                         typeKeyBoard: TextInputType.numberWithOptions(decimal: true),
//     //                                         TextTipeMask: [maskCPNJ],
//     //                                         colorTextField: Color.fromRGBO(170, 170, 170, 200),
//     //                                       ),
//     //                                     ),
//     //                                   ),
//     //
//     //                                   Container(
//     //                                     width: double.maxFinite,
//     //                                     child: Row(
//     //                                       children: [
//     //                                         Flexible(
//     //                                           child: Container(
//     //                                             width: double.maxFinite,
//     //                                             child: myTextField(
//     //                                               titleName: 'Valor minino',
//     //                                               descriptionName: 'R\$:',
//     //                                               changeTypeName: (text){valorMin = text;},
//     //                                               nomeDoComtrolador: _minValor,
//     //                                               typeKeyBoard: TextInputType.numberWithOptions(decimal: true),
//     //                                               TextTipeMask: null,
//     //                                               colorTextField: Color.fromRGBO(170, 170, 170, 200),
//     //                                               /*keyboardType: TextInputType.numberWithOptions(decimal: true),*/
//     //                                             ),
//     //                                           ),
//     //                                         ),
//     //                                         Text(' Até '),
//     //                                         Flexible(
//     //                                             child: Container(
//     //                                               width: double.maxFinite,
//     //                                               child: myTextField(
//     //                                                 titleName: 'Valor maximo',
//     //                                                 descriptionName: 'R\$:',
//     //                                                 changeTypeName: (text){valorMax = text;},
//     //                                                 nomeDoComtrolador: _maxValor,
//     //                                                 typeKeyBoard: TextInputType.number,
//     //                                                 TextTipeMask: null,
//     //                                                 colorTextField: Color.fromRGBO(170, 170, 170, 200),
//     //                                               ),
//     //                                             )
//     //                                         )
//     //                                       ],
//     //                                     ),
//     //                                   ),
//     //                                 ],
//     //                               ),
//     //                             ),
//     //                             Padding(
//     //                               padding: const EdgeInsets.all(8.0),
//     //                               child: Row(
//     //                                 children: [
//     //                                   Flexible(
//     //                                     child: GestureDetector(
//     //                                       child: Container(
//     //                                         height: 90,
//     //                                         width: MediaQuery.of(context).size.width,
//     //                                         child: Column(
//     //                                           children: [
//     //                                             Container(
//     //                                               height: 60,
//     //                                               width: 135,
//     //                                               decoration: BoxDecoration(
//     //                                                   color: isbuttonDisabled == false ?Colors.black26 : Colors.orange,
//     //                                                   borderRadius: BorderRadius.all(
//     //                                                     Radius.circular(100),
//     //                                                   )),
//     //                                               child: Row(
//     //                                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     //                                                 children: [
//     //                                                   Icon(Icons.cleaning_services, size: 30, color: Colors.white,),
//     //                                                   Text('Limpar', style: TextStyle(
//     //                                                       fontSize: 20,
//     //                                                       color: Colors.white
//     //                                                   ),),
//     //                                                 ],
//     //                                               ),
//     //                                             ),
//     //                                           ],
//     //                                         ),
//     //                                       ),
//     //                                       onTap:isbuttonDisabled == false ? null :(){
//     //                                         _exibeFiltrados(false);
//     //                                         print('clicando no botão de limpar dados do filtro');
//     //                                       },
//     //                                     ),
//     //                                   ),
//     //                                   Flexible(
//     //                                     child: GestureDetector(
//     //                                       child: Container(
//     //                                         height: 90,
//     //                                         width: MediaQuery.of(context).size.width,
//     //                                         child: Column(
//     //                                           children: [
//     //                                             Container(
//     //                                               height: 60,
//     //                                               width: 135,
//     //                                               decoration: BoxDecoration(
//     //                                                   color: Colors.blue,
//     //                                                   borderRadius: BorderRadius.all(
//     //                                                     Radius.circular(100),
//     //                                                   )),
//     //                                               child: Row(
//     //
//     //                                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//     //                                                 children: [
//     //                                                   Icon(Icons.search, size: 30, color: Colors.white,),
//     //                                                   Text('Buscar', style: TextStyle(
//     //                                                       fontSize: 20,
//     //                                                       color: Colors.white
//     //                                                   ),),
//     //                                                 ],
//     //                                               ),
//     //                                             ),
//     //                                           ],
//     //                                         ),
//     //                                       ),
//     //                                       onTap:(){
//     //                                         print('nome ${filtraCaixaeBanco.name}');
//     //                                         print('cnpj : ${filtraCaixaeBanco.cnpjempresa}');
//     //                                         print('Min: $valorMin -  Max: $valorMax');
//     //
//     //
//     //
//     //                                         _exibeFiltrados(true);
//     //                                         Navigator.of(context).pop();
//     //                                         // print('Esta clicando no botão buscar do filtro');
//     //                                       },
//     //                                     ),
//     //                                   ),
//     //                                 ],
//     //                               ),
//     //                             ),
//     //                           ],
//     //                         ),
//     //                       ),
//     //                     ]
//     //                 ),
//     //               ),
//     //             );
//     //           }
//     //        );
//     //     },
//     //   ),
//     // );
//   }
// }
