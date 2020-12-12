/* estamos criando uma extensão da classe string do dart */
import 'package:intl/intl.dart';

extension StringExtension on String {
  /* verifiying if the email is valid */
  bool isEmailValid() {
    final RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(this); /* getting access to the email called */
  }
}

/* number extension aplicada no tipo numerico */
extension NumberExtension on num {
  String formattedMoney() {
    return NumberFormat('R\$###,##0.00', 'pt-Br')
        .format(this); /* nomenclatura para formatar dinheiro pra reais */
  }
}

extension DateTimeExtension on DateTime {
  String formattedDate() {
    return DateFormat('dd/MM/yy HH:MM', 'pt-Br')
        .format(this); /* nomenclatura pra datas */
  }
}
