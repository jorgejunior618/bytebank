import 'package:bytebank/Components/generals/no_content_message.dart';
import 'package:bytebank/database/dao/contato_dao.dart';
import 'package:flutter/material.dart';

import 'package:bytebank/Components/loading_screen/LoadingScreen.dart';
import 'package:bytebank/models/Contato.dart';

class ListaContatos extends StatefulWidget {
  final ContatoDao _contatoDao = ContatoDao();
  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  redirectToForm(BuildContext context) {
    Navigator.pushNamed(context, '/contatos/criar')
        .then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferir'),
      ),
      body: FutureBuilder<List<Contato>>(
        initialData: [],
        future: widget._contatoDao.buscarContatos(),
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
              final List<Contato> contatos = snapshot.data;
              return Contatos(contatos);
              break;
          }
          return NoContentMessage('Algum erro desconhecido! :/');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => redirectToForm(context),
      ),
    );
  }
}

class Contatos extends StatelessWidget {
  Contatos(this.contatos);

  final List<Contato> contatos;

  _redirectToNewTransfer(BuildContext context, Contato contato) {
    Navigator.pushNamed(
      context,
      '/transacoes/criar',
      arguments: {
        'contact': contato,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (BuildContext context, int index) {
          return CardContato(
            contatos[index],
            onTap: () => _redirectToNewTransfer(context, contatos[index]),
          );
        });
  }
}

class CardContato extends StatelessWidget {
  final Contato contato;
  final Function onTap;

  const CardContato(this.contato, {@required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: ListTile(
            title: Text(
              contato.nome,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              contato.numero,
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
