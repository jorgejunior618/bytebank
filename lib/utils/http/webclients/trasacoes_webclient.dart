import 'dart:convert';

import 'package:bytebank/models/Transacao.dart';
import 'package:bytebank/utils/http/webClient.dart';
import 'package:http/src/response.dart';

class TransacaoWebClient {
  Uri _getUri(endpoint) {
    final url = Uri.https(baseURL, endpoint);
    return url;
  }

  Future<List<Transacao>> buscarTransferencias() async {
    Uri url = _getUri('transactions');

    final response = await client.get(url);
    final List<dynamic> decoded = jsonDecode(response.body);

    return decoded.map((json) => Transacao.fromJson(json)).toList();
  }

  Future<Transacao> criarTransferencia(
    Transacao transacao,
    String password,
  ) async {
    Uri url = _getUri('transactions');

    String encoded = jsonEncode(transacao.toJson());

    await Future.delayed(Duration(seconds: 10));
    final response = await client
        .post(
          url,
          headers: {
            'content-type': 'application/json',
            'password': '$password',
          },
          body: encoded,
        )
        .timeout(Duration(seconds: 20));
    if (response.statusCode == 200 || response.statusCode == 204)
      return Transacao.fromJson(jsonDecode(response.body));

    throw HttpException(getMessage(response.statusCode));
  }

  String getMessage(int statusCode) {
    if (!_exceptions.containsKey(statusCode)) return 'Erro de requisição';
    return _exceptions[statusCode];
  }

  static final Map<int, String> _exceptions = {
    400: 'Envio inesperado',
    401: 'Não autorizado, credenciais inválidas',
    409: 'Transferência já realizada',
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
