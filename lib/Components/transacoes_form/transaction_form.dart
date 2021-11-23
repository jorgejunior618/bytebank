import 'dart:async';
import 'package:bytebank/Components/loading_screen/LoadingScreen.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';
import 'package:bytebank/utils/dialog_autenticacao.dart';
import 'package:bytebank/utils/http/webclients/trasacoes_webclient.dart';
import 'package:bytebank/utils/navigation.dart';

import 'package:bytebank/models/Contato.dart';
import 'package:bytebank/models/Transacao.dart';
import 'package:bytebank/Components/generals/buttom.dart';
import 'package:bytebank/Components/generals/input.dart';
import 'package:bytebank/Components/generals/response_dialog.dart';

class TransacaoFormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map arguments = getNavigatorArguments(context);

    return TransacaoForm(arguments['contact']);
  }
}

class TransacaoForm extends StatefulWidget {
  final Contato contato;
  final TransacaoWebClient webClient = TransacaoWebClient();

  TransacaoForm(this.contato);

  @override
  _TransacaoFormState createState() => _TransacaoFormState();
}

class _TransacaoFormState extends State<TransacaoForm> {
  final TextEditingController _valorController = TextEditingController();
  final String _formId = Uuid().v4();

  bool _loading = false;

  _criarTransferencia(String password, BuildContext context) {
    final double valor = double.tryParse(_valorController.text);

    final double valorFinal =
        valor != null ? double.parse(valor.toStringAsFixed(2)) : null;
    final novaTransacao = Transacao(_formId, valorFinal, widget.contato);
    return _criar(novaTransacao, password, context);
  }

  Future _criar(Transacao novaTransacao, String password, context) async {
    setState(() {
      _loading = true;
    });
    final Transacao transacao = await widget.webClient
        .criarTransferencia(novaTransacao, password)
        .catchError(
      (error) {
        _messageFailure(context, 'Tempo de execução de transferencia excedida');
      },
      test: (error) => error is TimeoutException,
    ).catchError(
      (error) {
        _messageFailure(context, 'Falha na transação');
      },
      test: (e) => e is HttpException,
    ).catchError((error) {
      _messageFailure(context, 'Falha na transação');
    }).whenComplete(() {
      setState(() {
        _loading = false;
      });
    });

    if (transacao != null) {
      _messageSuccess(context, 'Transação realizada');
      Navigator.of(context).pop();
    }
  }

  void _messageSuccess(context, String text) {
    showDialog(
        context: context,
        builder: (builder) {
          return SuccessDialog(text);
        });
  }

  void _messageFailure(context, String text) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(
            'Erro desconhecido',
            title: text,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print('fomrID: $_formId');

    return Scaffold(
      appBar: AppBar(
        title: Text('Fazer transação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LoadingScreen(
                    message: 'Transferindo ...',
                  ),
                ),
                visible: _loading,
              ),
              Text(
                widget.contato.nome,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contato.numero,
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Input(
                controller: _valorController,
                labelText: 'Valor',
                hint: '00.00',
                prefix: 'R\$ ',
                isNumber: true,
                icon: Icons.monetization_on,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Buttom(
                  buttomTitle: 'Transferir',
                  onPress: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext contextDialog) {
                          return DialogAutenticacao(
                              onConfirm: (String password) {
                            _criarTransferencia(password, context);
                          });
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
