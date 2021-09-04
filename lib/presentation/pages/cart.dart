import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/data/api/service/order_service.dart';
import 'package:optovik/domain/bloc/auth/auth_bloc.dart';
import 'package:optovik/domain/bloc/cart/cart_bloc.dart';
import 'package:optovik/domain/bloc/order/order_cubit.dart';
import 'package:optovik/domain/bloc/order_form/order_form_cubit.dart';
import 'dart:core';
import 'package:optovik/domain/model/product.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/internal/dependencies/auth_module.dart';
import 'package:optovik/internal/dependencies/cart_module.dart';
import 'package:optovik/presentation/pages/order_form.dart';
import 'package:optovik/presentation/widgets/message_widget.dart';
import 'package:optovik/presentation/widgets/product_cart_widget.dart';
import 'package:optovik/presentation/widgets/product_section_widget.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).cart),
          bottom: TabBar(
            tabs: [
              BlocBuilder<CartBloc, CartState>(
                cubit: CartModule.cartBloc(),
                builder: (context, state) => Tab(
                  text: S.of(context).currentOrder + " (${state.orders.length})",
                ),
              ),
              BlocBuilder<CartBloc, CartState>(
                cubit: CartModule.cartBloc(),
                builder: (context, state) => Tab(
                  text: S.of(context).postponed + " (${state.postponed.length})",
                ),
              ),
            ],
            labelColor: Colors.white,
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          cubit: CartModule.cartBloc(),
          builder: (context, state) => TabBarView(children: [
            state.orders.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 10, bottom: 5),
                          child: Text(
                            S.of(context).productsInCart,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...state.orders
                            .map(
                              (Product e) => ProductCartWidget(
                                product: e,
                                id: e.id,
                                title: "${e.title}",
                                count: "${e.qty}",
                                price: "",
                                image: "${e.image}",
                                isOrder: true,
                              ),
                            )
                            .toList(),
                        ProductSectionWidget(
                          title: S.of(context).recommendedProducts,
                          products: [],
                        ),
                        TextButton(
                          onPressed: () {
                            CartModule.cartBloc().add(PostponeAll());
                          },
                          child: Row(
                            children: [
                              Icon(Icons.refresh),
                              SizedBox(width: 10),
                              Text(
                                S.of(context).moveOrderToDeferred.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              CartModule.cartBloc().add(ClearOrder());
                            },
                            child: Row(
                              children: [
                                Icon(Icons.clear),
                                SizedBox(width: 10),
                                Text(
                                  S.of(context).cleanProductCart.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  )
                : MessageWidget(
                    title: S.of(context).emptyCart,
                    message: S.of(context).emptyCartText,
                  ),
            state.postponed.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...state.postponed.map(
                          (e) => ProductCartWidget(
                            product: e,
                            id: e.id,
                            title: "${e.title}",
                            count: "${e.qty}",
                            price: "",
                            image: "${e.image}",
                            isOrder: false,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            CartModule.cartBloc().add(TransferToOrder());
                          },
                          child: Row(
                            children: [
                              Icon(Icons.shopping_cart),
                              SizedBox(width: 10),
                              Text(
                                S.of(context).transferProductsToOrder.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            CartModule.cartBloc().add(ClearPendingOrder());
                          },
                          child: Row(
                            children: [
                              Icon(Icons.clear),
                              SizedBox(width: 10),
                              Text(
                                S.of(context).deleteList.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : MessageWidget(
                    title: S.of(context).noDeferredItems,
                    message: S.of(context).noDeferredItemsText,
                  ),
          ]),
        ),
        bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
          cubit: CartModule.cartBloc(),
          builder: (context, state) => BottomAppBar(
            color: state.orders.isNotEmpty
                ? Colors.indigo
                : Colors.grey.shade400,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                minimumSize: Size(MediaQuery.of(context).size.width, 45),
              ),
              onPressed: state.orders.isNotEmpty
                  ? () {
                      toCart(context);
                    }
                  : null,
              child: Text(
                S.of(context).next.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Route<Object> route() {
    return MaterialPageRoute(
      builder: (context) => Cart(),
    );
  }

  void toCart(BuildContext context) {
    if (AuthModule.authBloc().state is AuthAuthenticated) {
      AuthAuthenticated state = AuthModule.authBloc().state;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderFormPage(
            orderFormCubit: OrderFormCubit(
                initForm: OrderFormState(
                    contacts:
                        "${state.user.firstName}, ${state.user.username}")),
            orderCubit: OrderCubit(
              authService: AuthModule.authService(),
              orderService: OrderService(),
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).pleaseLog)),
      );
    }
  }
}
