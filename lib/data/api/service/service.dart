import 'package:http/http.dart' as http;

abstract class Service {
  final baseUrl = 'http://optovikuz.com';

  final http.Client client = http.Client();

  final Map<String, String> headers = {
    'Authorization': 'Basic YWRtaW46YWRtaW5hZG1pbg==',
    'Accept-Charset': 'utf-8',
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
}
