import 'package:bytebank/Components/generals/buttom.dart';
import 'package:bytebank/Components/generals/response_dialog.dart';
import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:bytebank/models/Contato.dart';
import 'package:flutter/material.dart';

import 'package:bytebank/Components/Generals/Input.dart';

class CadastroContato extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criação de contato'),
      ),
      body: Formulario(),
    );
  }
}

class Formulario extends StatefulWidget {
  final ContatoDao _contatoDao = ContatoDao();

  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  _criar(context) {
    final String nome = _nomeController.text;
    final String numero = _numeroController.text;

    if (nome.length < 2) {
      return showDialog(
          context: context,
          builder: (builder) {
            return FailureDialog('Digite um nome com mais de 1 letra');
          });
    }
    if (int.tryParse(numero) == null || numero.contains('-')) {
      return showDialog(
          context: context,
          builder: (builder) {
            return FailureDialog(
              'Informe um número de conta sem caracteres especiais (. , / -) ou espaços',
            );
          });
    }
    Contato novoContato = Contato(
      0,
      nome,
      numero,
    );

    debugPrint('$novoContato');

    widget._contatoDao.save(novoContato).then((id) => showDialog(
          context: context,
          builder: (builder) {
            return SuccessDialog(
              '',
              title: 'Contato salvo',
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Input(
            labelText: 'Nome',
            isName: true,
            controller: _nomeController,
          ),
          Input(
            labelText: 'Numero da Conta',
            hint: '0000',
            isNumber: true,
            controller: _numeroController,
          ),
          Buttom(
            buttomTitle: 'Salvar',
            onPress: () => _criar(context),
          ),
        ],
      ),
    );
  }
}
