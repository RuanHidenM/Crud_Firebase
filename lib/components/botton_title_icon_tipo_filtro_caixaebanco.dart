import 'package:crud_firebase/components/button/button_menu_median_icon_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottonTitleIconTipoFiltroCaixaeBanxo extends StatefulWidget{
  BottonTitleIconTipoFiltroCaixaeBanxo(this.title, this.icon, this.selected);
  final String title;
  final IconData icon;
  final bool selected;

 // BottonTitleIconTipoFiltroCaixaeBanxo(this.title, this.icon, this.selected);
  _bottonTitleIconTipoFiltroCaixaeBanxo createState() => _bottonTitleIconTipoFiltroCaixaeBanxo();
}

class _bottonTitleIconTipoFiltroCaixaeBanxo extends State<BottonTitleIconTipoFiltroCaixaeBanxo> {
  get MediaWidth => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child:
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset: const Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 2.0,
                spreadRadius: 0.2,
              ),
            ],
          ),
          width: MediaWidth / 4,
          height: MediaWidth / 5.5,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 7, left: 7),
                      child: Icon(
                        widget.icon,
                        size: MediaWidth / 13,
                        color: widget.selected == true
                        ? Color.fromRGBO(245, 134, 52, 1)
                        :Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      '${widget.title}',
                      style: TextStyle(
                        fontSize: MediaWidth / 19,
                        color: widget.selected == true
                            ? Color.fromRGBO(245, 134, 52, 1)
                            :Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
