// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:projeto_programas/Services/programa_service.dart';

class AddPrograma extends StatefulWidget {
  AddPrograma({super.key});

  @override
  _AddProgramaState createState() => _AddProgramaState();
}

class _AddProgramaState extends State<AddPrograma> {
  final gerenteController = TextEditingController();
  final nomeController = TextEditingController();
  final dtInicioController = TextEditingController();
  final dtFimController = TextEditingController();
  String status = '0';

  final ProgramaService apiService = GetIt.I<ProgramaService>();

  bool _validateFields() {
    if (gerenteController.text.isEmpty ||
        nomeController.text.isEmpty ||
        dtInicioController.text.isEmpty ||
        dtFimController.text.isEmpty) {
      return false;
    }
    return true;
  }

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
                icon: Icon(Icons.card_membership),
                hintText: 'Id do Gerente',
                labelText: 'Id do Gerente',
              ),
              controller: gerenteController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.assignment),
                hintText: 'Nome do Programa:',
                labelText: 'Nome do Programa',
              ),
              controller: nomeController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.date_range),
                hintText: 'Data de Início:',
                labelText: 'Data de Início',
              ),
              controller: dtInicioController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.date_range),
                hintText: 'Data de Fim:',
                labelText: 'Data de Fim',
              ),
              controller: dtFimController,
            ),
            SizedBox(
              width: double.infinity,
              child: DropdownButton<String>(
                value: status,
                onChanged: (String? newValue) {
                  setState(() {
                    status = newValue!;
                  });
                },
                items: <String>['Inativo', 'Ativo']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value == 'Inativo' ? '0' : '1',
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Adicionar"),
                onPressed: () async {
                  if (_validateFields()) {
                    try {
                      await apiService.addPrograma(
                        int.parse(gerenteController.text),
                        nomeController.text,
                        dtInicioController.text,
                        dtFimController.text,
                        status,
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      print('Erro ao adicionar programa: $e');
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, preencha todos os campos.'),
                        backgroundColor: Colors.red,
                      ),
                    );
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
