import 'package:flutter/material.dart';

class DialogAutenticacao extends StatefulWidget {
  final Function(String) onConfirm;

  DialogAutenticacao({@required this.onConfirm});

  @override
  _DialogAutenticacaoState createState() => _DialogAutenticacaoState();
}

class _DialogAutenticacaoState extends State<DialogAutenticacao> {
  final TextEditingController _authController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Autenticação'),
      content: TextField(
        controller: _authController,
        obscureText: true,
        maxLength: 4,
        style: TextStyle(
          fontSize: 64.0,
          letterSpacing: 24.0,
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Confirmar'),
          onPressed: () {
            widget.onConfirm(_authController.text);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
