import 'package:bytebank/Components/generals/no_content_message.dart';
import 'package:bytebank/Components/loading_screen/LoadingScreen.dart';
import 'package:bytebank/models/Transacao.dart';
import 'package:bytebank/utils/http/webclients/trasacoes_webclient.dart';
import 'package:flutter/material.dart';

class ListaTransacoes extends StatelessWidget {
  final TransacaoWebClient webClient = TransacaoWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Transações'),
      ),
      body: FutureBuilder<List<Transacao>>(
        future: webClient.buscarTransferencias(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return LoadingScreen();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transacao> transacoes = snapshot.data;

                if (transacoes.length > 0) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transacao transacao = transacoes[index];
                      return TransacaoCard(transacao: transacao);
                    },
                    itemCount: transacoes.length,
                  );
                }
              }

              return NoContentMessage(
                'Ainda não há transferencias',
                icone: Icons.warning,
              );
              break;
          }

          return NoContentMessage('Algum erro desconhecido! :/');
        },
      ),
    );
  }
}

class TransacaoCard extends StatelessWidget {
  const TransacaoCard({
    @required this.transacao,
  });

  final Transacao transacao;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(
          'R\$ ${transacao.valor.toStringAsFixed(2).replaceAll('.', ',')}',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          transacao.contato.nome,
          style: TextStyle(
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
