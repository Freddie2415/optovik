import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/cart/cart_bloc.dart';
import 'package:optovik/internal/dependencies/cart_module.dart';
import 'package:optovik/presentation/pages/cart.dart';
import 'package:optovik/presentation/pages/home.dart';

class BottomAppBarWidget extends StatelessWidget {
  final bool isHome;

  const BottomAppBarWidget({Key key, this.isHome = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      cubit: CartModule.cartBloc(),
      builder: (context, state) => state.orders.isNotEmpty
          ? BottomAppBar(
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    !this.isHome
                        ? FlatButton(
                            height: 50,
                            child: Icon(
                              Icons.home,
                              color: Colors.lightGreen,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            },
                            minWidth: 5,
                          )
                        : Container(
                            width: 0,
                            height: 0,
                          ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Cart();
                            },
                          ),
                        ),
                        height: 50,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "КОРЗИНА",
                              style: TextStyle(
                                color: Colors.lightGreen,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.lightGreen,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(50),
                                ),
                              ),
                              child: Text(
                                "${state.orders.length}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Container(width: 0, height: 0),
    );
  }
}
