class Cidade {
  Cidade({this.id, this.nome});
  factory Cidade.fromJson(Map<String, dynamic> json) =>
      Cidade(id: json['id'], nome: json['nome']);
  int id;
  String nome;
  @override
  String toString() {
    return "Cidade { id: $id, name: $nome }";
  }
}
