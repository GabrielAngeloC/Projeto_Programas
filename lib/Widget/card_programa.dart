// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class CardPrograma extends StatelessWidget {
  const CardPrograma({
    super.key,
    required this.gerenteId,
    required this.nome,
    required this.dtInicio,
    required this.dtFim,
    required this.status,
    required this.onTap,
  });

  final int gerenteId;
  final String nome;
  final String dtInicio;
  final String dtFim;
  final String status;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 2,
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text("O Gernete responsavel é o de ID: ${gerenteId.toString()}"),
                      Text(
                        nome,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(dtInicio),
                      Text(dtFim),
                      Text(
                        status == '1' ? 'Ativo' : 'Inativo',
                        style: TextStyle(
                          color: status == '1' ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}