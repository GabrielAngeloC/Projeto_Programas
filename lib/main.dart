// ignore_for_file: prefer_const_constructors

import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projeto_programas/Screens/pagina_inicial.dart';
import 'package:projeto_programas/Services/programa_service.dart';

void setLocator() {
  GetIt.instance.registerLazySingleton(() => ProgramaService());
}

void main() async {
  await dotenv.load(fileName: '.env');
  setLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage());
  }
}
