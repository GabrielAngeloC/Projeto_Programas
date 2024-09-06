// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:projeto_programas/Models/ProgramaModel.dart';
import 'package:projeto_programas/Screens/add_programa.dart';
import 'package:projeto_programas/Services/programa_service.dart';
import 'package:projeto_programas/widget/card_programa.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, title});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Programa>?> futurosProgramas;
  ProgramaService get service => GetIt.I<ProgramaService>();

  @override
  void initState() {
    super.initState();
    futurosProgramas = service.getProgramas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text("Programas"),
      ),
      body: Container(
      color: Colors.black,
      child: FutureBuilder<List<Programa>?>(
           future: futurosProgramas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum programa encontrado"));
          } else {
            List<Programa> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final programa = data[index];
                return CardPrograma(
                  gerenteId: programa.gerenteId ?? 0, // Valor padrão se null
                  nome: programa.nome ?? 'Nome não disponível', // Valor padrão se null
                  dtInicio: programa.dtInicio ?? 'Data não disponível', // Valor padrão se null
                  dtFim: programa.dtFim ?? 'Data não disponível', // Valor padrão se null
                  status: programa.status ?? false, // Valor padrão se null
                );
              },
            );
          }
        },
      ),
    ),
    floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddPrograma()));
      },
      child: Icon(Icons.add),
      ),
    );
  }
}