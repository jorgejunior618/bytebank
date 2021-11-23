import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:sqflite/sqflite.dart';

class ContatoDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_nome TEXT, '
      '$_numero TEXT'
      ')';
  static const String _tableName = 'contatos';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _numero = 'numero';

  Map<String, dynamic> _toMap(Contato contato) {
    final Map<String, dynamic> mapaContatos = Map();
    mapaContatos[_nome] = contato.nome;
    mapaContatos[_numero] = contato.numero;
    return mapaContatos;
  }

  List<Contato> _toOrdenedList(List<Map<String, dynamic>> response) {
    final List<Contato> contatos = [];

    for (Map<String, dynamic> row in response) {
      final Contato contato = Contato(
        row[_id],
        row[_nome],
        row[_numero],
      );

      contatos.add(contato);
    }
    contatos.sort((a, b) => a.nome.compareTo(b.nome));
    return contatos;
  }

  Future<int> save(Contato contato) async {
    Map<String, dynamic> mapaContatos = _toMap(contato);

    final Database db = await getDataBase();
    return db.insert('$_tableName', mapaContatos);
  }

  Future<List<Contato>> buscarContatos() async {
    final Database db = await getDataBase();
    List<Map<String, dynamic>> response = await db.query('$_tableName');
    List<Contato> contatos = _toOrdenedList(response);

    return contatos;
  }
}
