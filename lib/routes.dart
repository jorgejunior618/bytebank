import 'package:bytebank/Components/transacoes_form/transaction_form.dart';
import 'package:flutter/material.dart';

import 'package:bytebank/Components/home_page/home_page.dart';
import 'package:bytebank/Components/contatos_lista/contatos_lista.dart';
import 'package:bytebank/Components/contatos_formulario/formulario.dart';
import 'package:bytebank/Components/transacoes_lista/transacoes_lista.dart';

Map<String, WidgetBuilder> appRoutes(BuildContext context) {
  return <String, WidgetBuilder>{
    '/': (context) => HomePage(),
    '/contatos': (context) => ListaContatos(),
    '/contatos/criar': (context) => CadastroContato(),
    '/transacoes': (context) => ListaTransacoes(),
    '/transacoes/criar': (context) => TransacaoFormContainer(),
  };
}
