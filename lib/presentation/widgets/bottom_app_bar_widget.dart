import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/cart/cart_bloc.dart';
import 'package:optovik/generated/l10n.dart';
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
      builder: (context, state) => BottomAppBar(
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
                          HomePage.route(),
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
                    Cart.route(),
                  ),
                  height: 50,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        S.of(context).cart.toUpperCase(),
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
                      SizedBox(
                        width: 10,
                      ),
                      Stack(
                        children: <Widget>[
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.lightGreen,
                            size: 28,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 12,
                                minHeight: 12,
                              ),
                              child: Text(
                                '${state.orders.length}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
