
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LargeButtonIconTitleOptionCompany extends StatelessWidget {
  LargeButtonIconTitleOptionCompany(this.title,this.selected);
  final String title; //TODO: Titulo do butão
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(width: 3, color: Colors.orange),
          ),
        ),
          height: 50,
          width: 270,
        //width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:8, right: 10, left: 8,bottom: 8),
                child: Icon( Icons.work_outline,
                    size: 30,
                    color: Colors.indigo
                ),
              ),

              Flexible(
                child: Text(title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}


