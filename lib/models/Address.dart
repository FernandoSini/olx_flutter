import 'package:olx_mobx/models/Cidades.dart';
import 'package:olx_mobx/models/Estados.dart';

class Address {
  Address({this.estado, this.cidade, this.cep, this.district});
  Estados estado;
  Cidade cidade;

  String cep;
  String district;

  @override
  String toString() {
    return "Address: { Estado: $estado, cidade: $cidade,  distrito: $district}";
  }
}
