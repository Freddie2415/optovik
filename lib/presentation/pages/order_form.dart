import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/cart/cart_bloc.dart';
import 'package:optovik/domain/bloc/order/order_cubit.dart';
import 'package:optovik/domain/bloc/order_form/order_form_cubit.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/internal/dependencies/cart_module.dart';
import 'package:optovik/presentation/pages/success_order.dart';
import 'package:optovik/presentation/widgets/loading_widget.dart';

class OrderFormPage extends StatelessWidget {
  final OrderFormCubit orderFormCubit;
  final OrderCubit orderCubit;

  OrderFormPage({
    Key key,
    @required this.orderFormCubit,
    @required this.orderCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).makingAnOrder),
      ),
      body: BlocListener<OrderCubit, OrderState>(
        cubit: orderCubit,
        listener: (context, state) {
          if (state is OrderFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("${state.message}")));
          }
          if (state is OrderSuccess) {
            CartModule.cartBloc().add(ClearOrder());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SuccessOrder(state.id),
              ),
            );
          }
        },
        child: BlocBuilder<OrderFormCubit, OrderFormState>(
          cubit: orderFormCubit,
          builder: (context, state) {
            return ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.location_on_outlined),
                  title: Text(S.of(context).deliveryAddress),
                  subtitle: ListItemSubTitle(
                    text: state.address,
                    errorText: S.of(context).enterDeliveryAddress,
                  ),
                  onTap: () async {
                    final address = await showDialog(
                      context: context,
                      builder: (context) =>
                          InputDialog(hintText: S.of(context).enterDeliveryAddress),
                    );
                    orderFormCubit.changeAddress(address);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.contact_phone_outlined),
                  title: Text(S.of(context).yourContacts),
                  subtitle: ListItemSubTitle(
                    text: state.contacts,
                    errorText: S.of(context).enterYourContacts,
                  ),
                  onTap: () async {
                    final contacts = await showDialog(
                      context: context,
                      builder: (context) => ContactDialog(),
                    );
                    orderFormCubit.changeContact(contacts);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.local_shipping_outlined),
                  title: Text(S.of(context).deliveryMethod),
                  subtitle: Text(
                    state.method,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.payment),
                  title: Text(S.of(context).paymentMethod),
                  subtitle: Text(
                    state.paymentText,
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    final payment = await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return PaymentBottomSheet(payment: state.payment);
                      },
                    );
                    orderFormCubit.changePayment(payment);
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.comment_outlined),
                  title: Text(S.of(context).commentOnTheOrder),
                  subtitle: Text(
                    state.comment.isEmpty
                        ? S.of(context).canLeaveComment
                        : state.comment,
                    style: TextStyle(
                      color: state.comment.isEmpty ? Colors.grey : Colors.green,
                      fontWeight: state.comment.isEmpty
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                  onTap: () async {
                    final comment = await showDialog(
                      context: context,
                      builder: (context) =>
                          InputDialog(hintText: S.of(context).commentOnTheOrder),
                    );
                    orderFormCubit.changeComment(comment);
                  },
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<OrderFormCubit, OrderFormState>(
        cubit: orderFormCubit,
        builder: (context, orderFormState) {
          return BlocBuilder<OrderCubit, OrderState>(
            cubit: orderCubit,
            builder: (context, orderCubitState) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 40),
                    elevation: 0,
                    shadowColor: Colors.white.withOpacity(0),
                    splashFactory: NoSplash.splashFactory,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                child: orderCubitState is OrderLoading
                    ? SizedBox(
                        child: LoadingWidget(strokeWidth: 2),
                        width: 30,
                        height: 30,
                      )
                    : Text(
                        S.of(context).order,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                onPressed: !(orderCubitState is OrderLoading) &&
                        orderFormState.isValidOrder
                    ? () {
                        orderCubit.sendOrder(orderFormState);
                      }
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}

class ListItemSubTitle extends StatelessWidget {
  final String text;
  final String errorText;

  bool get isValid => text != null && text.isNotEmpty;

  const ListItemSubTitle({Key key, this.text, this.errorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      isValid ? text : errorText,
      style: TextStyle(
        color: isValid ? Colors.green : Colors.redAccent,
        fontWeight: isValid ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}

class PaymentBottomSheet extends StatefulWidget {
  final Payments payment;

  PaymentBottomSheet({Key key, this.payment}) : super(key: key);

  @override
  _PaymentBottomSheetState createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  Payments _payment = Payments.CASH;

  @override
  void initState() {
    super.initState();
    _payment = widget.payment;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          RadioListTile<Payments>(
            title: Text(S.of(context).cash),
            subtitle: Text(S.of(context).paymentInCash),
            value: Payments.CASH,
            groupValue: _payment,
            onChanged: _onPaymentChanged,
          ),
          RadioListTile<Payments>(
            title: Text(S.of(context).paymentOnline),
            subtitle: Text(S.of(context).paymentViaPaymeClick),
            value: Payments.ONLINE,
            groupValue: _payment,
            onChanged: _onPaymentChanged,
          ),
          RadioListTile<Payments>(
            title: Text(
              S.of(context).byCard,
              style: TextStyle(color: Colors.black),
            ),
            subtitle: Text(S.of(context).paymentViaCard),
            value: Payments.CARD,
            groupValue: _payment,
            onChanged: _onPaymentChanged,
          ),
        ],
      ),
    );
  }

  void _onPaymentChanged(Payments value) {
    setState(() {
      _payment = value;
    });
    Navigator.pop(context, _payment);
  }
}

class InputDialog extends StatelessWidget {
  final String hintText;

  InputDialog({Key key, this.hintText}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 3,
                      controller: inputController,
                      validator: _validator,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        hintText: hintText,
                        hintMaxLines: 2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text(
                        S.of(context).save,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Navigator.of(context).pop(inputController.text);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _validator(String value) {
    return value.trim().isEmpty ? S.current.fieldRequired : null;
  }
}

class ContactDialog extends StatelessWidget {
  ContactDialog({Key key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -40.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.red,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: fullNameController,
                      validator: _validator,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        hintText: S.of(context).fullName,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      validator: _validator,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        hintText: S.of(context).phoneNumber,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text(
                        S.of(context).save,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Navigator.of(context).pop(
                              "${fullNameController.text}, ${phoneController.text}");
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _validator(String value) {
    return value.trim().isEmpty ? S.current.fieldRequired : null;
  }
}

enum Payments { CARD, CASH, ONLINE }
