import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/data/api/service/order_service.dart';
import 'package:optovik/domain/bloc/order_list/order_list_cubit.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/internal/dependencies/auth_module.dart';
import 'package:optovik/domain/bloc/auth/auth_bloc.dart';
import 'package:optovik/presentation/pages/categories.dart';
import 'package:optovik/presentation/pages/feedback.dart';
import 'package:optovik/presentation/pages/info.dart';
import 'package:optovik/presentation/pages/login.dart';
import 'package:optovik/presentation/pages/my_orders.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          BlocBuilder(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    child: Text(
                      "${state.user.firstName[0].toUpperCase() ?? ''}",
                      style: TextStyle(fontSize: 40),
                    ),
                    backgroundColor: Theme.of(context).primaryColorDark,
                    foregroundColor: Theme.of(context).canvasColor,
                  ),
                  accountName:
                      Text("${state.user.firstName} ${state.user.lastName}"),
                  accountEmail: Text("${state.user.username}"),
                );
              }
              return DrawerHeader(
                child: Text(
                  'Optovik.uz',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                ),
              );
            },
            cubit: AuthModule.authBloc(),
          ),
          BlocBuilder(
            cubit: AuthModule.authBloc(),
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return SizedBox();
              }
              return ListTile(
                leading: Icon(
                  Icons.account_circle_sharp,
                  color: Colors.lightGreen,
                ),
                title: Text(S.current.loginRegistration),
                onTap: () => _loginRegister(context),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.widgets,
              color: Colors.lightGreen,
            ),
            title: Text(S.current.catalogAndSearch),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, CategoriesPage.route());
            },
          ),
          BlocBuilder(
            cubit: AuthModule.authBloc(),
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.lightGreen,
                  ),
                  title: Text(S.current.myOrders),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => OrderListCubit(
                              OrderService(), AuthModule.authService()),
                          child: MyOrdersPage(),
                        ),
                      ),
                    );
                  },
                );
              }
              return SizedBox();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.lightGreen,
            ),
            title: Text(S.current.info),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Info(),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.lightGreen,
            ),
            title: Text(S.current.feedback),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedBack(),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          BlocBuilder(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.lightGreen,
                  ),
                  title: Text(S.current.logout),
                  onTap: () {
                    AuthModule.authBloc().add(LoggedOut());
                    _loginRegister(context);
                  },
                );
              }
              return const SizedBox();
            },
            cubit: AuthModule.authBloc(),
          )
        ],
      ),
    );
  }

  void _loginRegister(context) {
    Navigator.pushReplacement(
      context,
      LoginPage.route(
        loginBloc: AuthModule.loginBloc(),
        authBloc: AuthModule.authBloc(),
      ),
    );
  }
}
