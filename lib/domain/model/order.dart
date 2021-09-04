import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optovik/domain/model/item.dart';

class Order {
  final dynamic id;
  final dynamic created;
  final dynamic user;
  final dynamic status;
  final dynamic isPaid;
  final List<Item> orderItems;
  final dynamic comments;
  final dynamic deliver;
  final dynamic paymentMethod;
  final dynamic address;
  final dynamic contact;
  final dynamic total;

  Order({
    this.id,
    this.created,
    this.user,
    this.status,
    this.isPaid,
    this.orderItems,
    this.comments,
    this.deliver,
    this.paymentMethod,
    this.address,
    this.contact,
    this.total,
  });

  get statusColor {
    Color color;
    switch (status) {
      case 'created':
        color = Colors.amber;
        break;
      case 'available':
        color = Colors.indigo;
        break;
      case 'framed':
        color = Colors.indigoAccent;
        break;
      case 'sent':
        color = Colors.blueAccent;
        break;
      case 'delivered':
        color = Colors.green;
        break;
      default:
        color = Colors.black87;
    }
    return color;
  }

  get statusTitle {
    String title;
    switch (status) {
      case 'created':
        title = 'Заказ Создан';
        break;
      case 'available':
        title = 'Есть в наличии';
        break;
      case 'framed':
        title = 'Оформлено';
        break;
      case 'sent':
        title = 'Отправлено';
        break;
      case 'delivered':
        title = 'Доставлено';
        break;
      default:
        title = 'Заказ Создан';
    }
    return title;
  }

  get totalText {
    final format = NumberFormat();
    return format.format(total).replaceAll(',', ' ') + ' сум';
  }
}
