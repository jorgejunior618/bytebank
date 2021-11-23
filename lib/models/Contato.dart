class Contato {
  Contato(
    this.id,
    this.nome,
    this.numero,
  );

  final int id;
  final String nome;
  final String numero;

  Contato.fromJson(Map<String, dynamic> json)
      : nome = json['name'],
        id = json['id'],
        numero = json['accountNumber'].toString();

  @override
  String toString() {
    return '{ nome: $nome, numero: $numero }';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': nome,
        'accountNumber': int.parse(numero),
      };
}
