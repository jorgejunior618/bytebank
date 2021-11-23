import 'package:bytebank/models/Contato.dart';

class Transacao {
  final String id;
  final double valor;
  final Contato contato;

  Transacao(
    this.id,
    this.valor,
    this.contato,
  );

  Transacao.fromJson(Map<String, dynamic> json)
      : valor = json['value'],
        id = json['id'],
        contato = Contato.fromJson(json['contact']);
  Map<String, dynamic> toJson() => {
        'value': valor,
        'id': id,
        'contact': contato.toJson(),
      };
  @override
  String toString() {
    return 'Transacao{valor: $valor, contato: $contato}';
  }
}
