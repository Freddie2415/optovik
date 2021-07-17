part of 'order_form_cubit.dart';

class OrderFormState extends Equatable {
  const OrderFormState({
    this.address = '',
    this.contacts = '',
    this.method = "Доставка в указанный адрес",
    this.payment = Payments.CASH,
    this.comment = '',
  });

  final String address;
  final String contacts;
  final String method;
  final Payments payment;
  final String comment;

  String get paymentText {
    String text = "";
    switch (payment) {
      case Payments.CARD:
        text = "Оплата после доставки через карту";
        break;
      case Payments.CASH:
        text = "Оплата наличными после доставки";
        break;
      case Payments.ONLINE:
        text = "Онлайн оплата через Click, Payme и т.д";
        break;
    }

    return text;
  }

  bool get isValidOrder {
    return address.isNotEmpty && contacts.isNotEmpty;
  }

  OrderFormState copyWith({
    String address,
    String contacts,
    String method,
    Payments payment,
    String comment,
  }) {
    return OrderFormState(
      address: address ?? this.address,
      contacts: contacts ?? this.contacts,
      method: method ?? this.method,
      payment: payment ?? this.payment,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object> get props => [address, contacts, method, payment, comment];

  String getJsonPayload() {
    String paymentMethod = 'cod';
    switch (payment) {
      case Payments.CARD:
        paymentMethod = "card";
        break;
      case Payments.CASH:
        paymentMethod = "cod";
        break;
      case Payments.ONLINE:
        paymentMethod = "online";
        break;
    }

    final List<Product> items = CartModule.cartBloc().state.orders;
    final List<int> productList = items.map((e) => e.id).toList();

    return jsonEncode({
      "address": address,
      "contact": contacts,
      "status": "created",
      "products_list": productList,
      "is_paid": false,
      "deliver_id": 1,
      "payment_method": paymentMethod
    });
  }
}
