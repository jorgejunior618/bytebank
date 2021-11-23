import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http/http.dart';

import 'package:bytebank/utils/http/interceptors/interceptors.dart';

String baseURL = '6634b18b0476.ngrok.io';
Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 25),
);
