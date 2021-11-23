import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  redirectToContatos(BuildContext context) {
    Navigator.pushNamed(context, '/contatos');
  }

  redirectToTranferencias(BuildContext context) {
    Navigator.pushNamed(context, '/transacoes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            'images/bytebank_logo.png',
          ),
          Container(
            height: 110.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _ContainerButton(
                  text: 'Transferir',
                  icon: Icons.monetization_on,
                  onTap: () => redirectToContatos(context),
                ),
                _ContainerButton(
                  text: 'Transferências',
                  icon: Icons.description,
                  onTap: () => redirectToTranferencias(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContainerButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;

  _ContainerButton({
    this.text,
    this.icon,
    @required this.onTap,
  })  : assert(icon != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 150,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
