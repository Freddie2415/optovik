import 'dart:convert';

import 'package:http/http.dart';
import 'package:optovik/data/api/service/service.dart';
import 'package:optovik/domain/bloc/order_form/order_form_cubit.dart';

class OrderService extends Service {
  Future<String> create(String token, OrderFormState orderForm) async {
    var headers = this.headers;

    headers['Authorization'] = "Bearer $token";
    final payload = orderForm.getJsonPayload();

    final Response response = await this.client.post(
          "${this.baseUrl}/api/v1/orders/",
          headers: headers,
          body: payload,
        );

    var json = jsonDecode(utf8.decode(response.bodyBytes));
    print(json);
    print(headers);
    print(payload);

    if (response.statusCode == 201) {
      var json = jsonDecode(utf8.decode(response.bodyBytes));

      return json['id'];
    } else {
      throw "Ошибка отправки формы";
    }
  }
}
