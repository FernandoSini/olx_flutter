class Estados {
  Estados({this.id, this.sigla, this.nome});
  /* Usando o factory para criar um novo objeto , vai buscar na lista(api) de estados e retornar aqui*/
  factory Estados.fromJson(Map<String, dynamic> json) => Estados(
       id: json["id"],
        sigla: json["sigla"],
        nome: json["nome"],
      );

  /* Estados ou UF */
  int id;
  String sigla;
  String nome;

  @override
  String toString() {
    return "Estado { id: $id, sigla: $sigla, nome: $nome }";
  }
}
