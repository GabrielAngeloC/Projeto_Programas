// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:projeto_programas/Models/ProgramaModel.dart';
import 'package:projeto_programas/Screens/add_programa.dart';
import 'package:projeto_programas/Screens/update_programa.dart';
import 'package:projeto_programas/Services/programa_service.dart';
import 'package:projeto_programas/widget/card_programa.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, title});

  @override
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
                    gerenteId: programa.gerenteId ?? 0,
                    nome: programa.nome ?? 'Nome não disponível',
                    dtInicio: programa.dtInicio ?? 'Data não disponível',
                    dtFim: programa.dtFim ?? 'Data não disponível',
                    status: programa.status ?? '0',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdatePrograma(
                            gerenteId: programa.gerenteId ?? 0,
                            nome: programa.nome ?? 'Nome não disponível',
                            dtInicio: programa.dtInicio ?? 'Data não disponível',
                            dtFim: programa.dtFim ?? 'Data não disponível',
                            status: programa.status ?? '0',
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPrograma()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
