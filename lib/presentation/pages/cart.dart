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
          title: Text(S.current.cart),
          bottom: TabBar(
            tabs: [
              BlocBuilder<CartBloc, CartState>(
                cubit: CartModule.cartBloc(),
                builder: (context, state) => Tab(
                  text: S.current.currentOrder + " (${state.orders.length})",
                ),
              ),
              BlocBuilder<CartBloc, CartState>(
                cubit: CartModule.cartBloc(),
                builder: (context, state) => Tab(
                  text: S.current.postponed + " (${state.postponed.length})",
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
                            S.current.productsInCart,
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
                          title: S.current.recommendedProducts,
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
                                S.current.moveOrderToDeferred.toUpperCase(),
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
                                  S.current.cleanProductCart.toUpperCase(),
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
                    title: S.current.emptyCart,
                    message: S.current.emptyCartText,
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
                                S.current.transferProductsToOrder.toUpperCase(),
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
                                S.current.deleteList.toUpperCase(),
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
                    title: S.current.noDeferredItems,
                    message: S.current.noDeferredItemsText,
                  ),
          ]),
        ),
        bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
          cubit: CartModule.cartBloc(),
          builder: (context, state) => BottomAppBar(
            color: state.orders.isNotEmpty
                ? Colors.lightGreen
                : Colors.grey.shade400,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen,
                minimumSize: Size(MediaQuery.of(context).size.width, 45),
              ),
              onPressed: state.orders.isNotEmpty
                  ? () {
                      toCart(context);
                    }
                  : null,
              child: Text(
                S.current.next.toUpperCase(),
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
        SnackBar(content: Text(S.current.pleaseLog)),
      );
    }
  }
}
