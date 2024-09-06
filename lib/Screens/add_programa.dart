// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:projeto_programas/Services/programa_service.dart';

class AddPrograma extends StatelessWidget {
  AddPrograma({super.key});

  final gerenteController = TextEditingController();
  final nomeController = TextEditingController();
  final dtInicioController = TextEditingController();
  final dtFimController = TextEditingController();
  final statusController = ValueNotifier<bool>(false);

  final ProgramaService apiService = GetIt.I<ProgramaService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novo Programa")),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.assignment),
                hintText: 'Id do Gerente',
                labelText: 'Digite aqui',
              ),
              controller: gerenteController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.assignment),
                hintText: 'Nome do Programa:',
                labelText: 'Digite aqui',
              ),
              controller: nomeController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.date_range),
                hintText: 'Data de Início:',
                labelText: 'Digite aqui',
              ),
              controller: dtInicioController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.date_range),
                hintText: 'Data de Fim:',
                labelText: 'Digite aqui',
              ),
              controller: dtFimController,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: statusController,
              builder: (context, status, child) {
                return Row(
                  children: [
                    Text("Programa Finalizado?"),
                    Checkbox(
                      value: status,
                      onChanged: (bool? newValue) {
                        statusController.value = newValue ?? false;
                      },
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Adicionar"),
                onPressed: () async {
                  try {
                    await apiService.addPrograma(
                      nomeController.text,
                      dtInicioController.text,
                      dtFimController.text,
                      statusController.value,
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    print('Erro ao adicionar programa: $e');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}