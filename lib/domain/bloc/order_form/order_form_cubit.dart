import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/internal/dependencies/cart_module.dart';
import 'package:optovik/presentation/pages/order_form.dart';
import 'package:meta/meta.dart';

part 'order_form_state.dart';

class OrderFormCubit extends Cubit<OrderFormState> {
  final OrderFormState initForm;

  OrderFormCubit({@required this.initForm}) : super(initForm);

  changeAddress(String address) {
    emit(state.copyWith(address: address));
  }

  changeContact(String contacts) {
    emit(state.copyWith(contacts: contacts));
  }

  changeMethod(String method) {
    emit(state.copyWith(method: method));
  }

  changePayment(Payments payment) {
    emit(state.copyWith(payment: payment));
  }

  changeComment(String comment) {
    emit(state.copyWith(comment: comment));
  }
}
