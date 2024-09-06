// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:projeto_programas/Screens/update_programa.dart';

class CardPrograma extends StatelessWidget {
  const CardPrograma(
      {super.key,
      required this.gerenteId,
      required this.nome,
      required this.dtInicio,
      required this.dtFim,
      required this.status,
      });

  final int gerenteId;
  final String nome;
  final String dtInicio;
  final String dtFim;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdatePrograma(
                gerenteId: gerenteId,
                nome: nome,
                dtInicio: dtInicio,
                dtFim: dtFim,
                status: status,
              ),
            ),
          );
        },
        child: Card(
          elevation: 2,
          child: SizedBox(
            width: double.infinity,
            child: Row(children: [
              Expanded(
                child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(gerenteId.toString()),
                  Text(nome, style: TextStyle(fontSize: 20),),
                  Text(dtInicio),
                  Text(dtFim),
                  
              ],)),
            ],)
            ),
          ),
        ),
      );
  }
}
