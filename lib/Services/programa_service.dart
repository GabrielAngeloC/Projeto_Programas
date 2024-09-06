import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:projeto_programas/Models/ProgramaModel.dart';
import 'package:http/http.dart' as http;

class ProgramaService {
  final String baseUrl = dotenv.get('BASE_URL');
  // ignore: body_might_complete_normally_nullable
  Future<List<Programa>?> getProgramas() async {
    final response = await http
        .get(Uri.parse('$baseUrl/listar'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((e) => Programa.fromJson(e)).toList();
    } else {
      null;
    }
  }

  Future<void> addPrograma(int id, String nome, String dtInicio, String dtFim, String status) async {
    final response = await http.post(
      Uri.http("$baseUrl/cadastrar"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'gerete_id': id,
        'nome': nome,
        'dtInicio': dtInicio,
        'dtFim': dtFim,
        'status': status,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao adicionar programa');
    }
  }

  Future<void> updatePrograma(
      int id, String nome, String dtInicio, String dtFim, String status) async {
    final response = await http.put(
      Uri.parse(
          '$baseUrl/atualizar/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nome': nome,
        'dtInicio': dtInicio,
        'dtFim': dtFim,
        'status': status,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Falha ao atualizar o programa');
    }
  }

  Future<void> deletePrograma(int id) async {
    final response = await http.delete(
      Uri.http(baseUrl, "/deletar/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar programa');
    }
  }
}
