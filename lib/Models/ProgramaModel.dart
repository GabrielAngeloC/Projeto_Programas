// ignore_for_file: file_names, prefer_collection_literals, unnecessary_new

class Programa{
  int? gerenteId;
  String? nome;
  String? dtInicio;
  String? dtFim;
  String? status;


  Programa({this.gerenteId, this.nome, this.dtInicio, this.dtFim, this.status});

  Programa.fromJson(Map<dynamic, dynamic> json){
    gerenteId = json['gerente_id'];
    nome = json['nome'];
    dtInicio = json['dtInicio'];
    dtFim = json['dtFim'];
    status = json['status'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['gerente_id'] = gerenteId;
    data['nome'] = nome;
    data['dtInicio'] = dtInicio;
    data['dtFim'] = dtFim;
    data['status'] = status;
    return data;
  }

}