// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, duplicate_ignore, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:projeto_programas/Services/programa_service.dart';

class UpdatePrograma extends StatefulWidget {
  const UpdatePrograma(
      {super.key,
      required this.gerenteId,
      required this.nome,
      required this.dtInicio,
      required this.dtFim,
      required this.status});

  final int gerenteId;
  final String nome;
  final String dtInicio;
  final String dtFim;
  final bool status;

  @override
  _UpdateProgramaState createState() => _UpdateProgramaState();
}

class _UpdateProgramaState extends State<UpdatePrograma> {
  final programatxt = TextEditingController();
  final dtIniciotxt = TextEditingController();
  final dtFimtxt = TextEditingController();
  late bool? status;

  final ProgramaService apiService = GetIt.I<ProgramaService>();

  @override
  void initState() {
    super.initState();

    programatxt.text = widget.nome;
    dtIniciotxt.text = widget.dtInicio;
    dtFimtxt.text = widget.dtFim;
    status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Atualizar Programa")),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.assignment),
                hintText: 'Programa:',
              ),
              controller: programatxt,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.date_range),
                hintText: 'Data inicial:',
              ),
              controller: dtIniciotxt,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.date_range),
                hintText: 'Data final:',
              ),
              controller: dtFimtxt,
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Programa Finalizado?"),
                    Checkbox(
                      value: status,
                      onChanged: (bool? newValue) {
                        setState(() {
                          status = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Atualizar"),
                onPressed: () async {
                  await _atualizarPrograma();
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Deletar"),
                onPressed: () async {
                  await _deletarPrograma();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _atualizarPrograma() async {
    try {
      await apiService.updatePrograma(
        widget.gerenteId,
        programatxt.text,
        dtIniciotxt.text,
        dtFimtxt.text,
        status!,
      );
    } catch (e) {
      print('Erro ao atualizar o programa: $e');
    }
  }

  Future<void> _deletarPrograma() async {
    try {
      await apiService.deletePrograma(widget.gerenteId);
    } catch (e) {
      print('Erro ao deletar o programa: $e');
    }
  }
}