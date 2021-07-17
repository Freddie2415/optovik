import 'dart:convert';

import 'package:http/http.dart';
import 'package:optovik/data/api/service/service.dart';
import 'package:optovik/domain/bloc/order_form/order_form_cubit.dart';
import 'package:optovik/domain/model/item.dart';
import 'package:optovik/domain/model/order.dart';

class OrderService extends Service {
  Future<dynamic> create(String token, OrderFormState orderForm) async {
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

  Future<List<Order>> getAll(String token) async {
    var headers = this.headers;

    headers['Authorization'] = "Bearer $token";

    final Response response = await this.client.get(
          "${this.baseUrl}/api/v1/orders?ordering=-pk",
          headers: headers,
        );

    var json = jsonDecode(utf8.decode(response.bodyBytes));

    final orders = json['results'] as List;
    final List<Order> orderList = orders.map((order) {
      List orderItems = order['order_items'] as List;

      List<Item> items = orderItems.map((item) {
        var product = item['product'];
        List photos = product['photos'] as List ?? [];
        var image = photos.first['photo'] ?? null;
        return Item(
          id: item['id'],
          image: image,
          titleRu: product['title_ru'],
          titleUz: product['title_uz'],
          quantity: item['count']
        );
      }).toList();

      return Order(
        id: order['id'],
        address: order['address'],
        status: order['status'],
        comments: order['comments'],
        contact: order['contact'],
        created: order['created'],
        deliver: order['deliver'],
        isPaid: order['is_paid'],
        orderItems: items,
        paymentMethod: order['payment_method'],
        total: order['total'],
        user: order['user'],
      );
    }).toList();

    return orderList;
  }
}
