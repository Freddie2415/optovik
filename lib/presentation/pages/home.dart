import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/auth/auth_bloc.dart';
import 'package:optovik/domain/bloc/home/home_bloc.dart';
import 'package:optovik/internal/dependencies/auth_module.dart';
import 'package:optovik/internal/dependencies/home_module.dart';
import 'package:optovik/presentation/pages/categories.dart';
import 'package:optovik/presentation/pages/feedback.dart';
import 'package:optovik/presentation/pages/info.dart';
import 'package:optovik/presentation/pages/login.dart';
import 'package:optovik/presentation/pages/my_orders.dart';
import 'package:optovik/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:optovik/presentation/widgets/category_section_widget.dart';
import 'package:optovik/presentation/widgets/fault_widget.dart';
import 'package:optovik/presentation/widgets/loading_widget.dart';
import 'package:optovik/presentation/widgets/product_section_widget.dart';
import 'package:optovik/presentation/widgets/slider_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Optovik.uz"),
        actions: [
          IconButton(
            icon: Icon(Icons.widgets_outlined),
            onPressed: () {
              Navigator.of(context).push(CategoriesPage.route());
            },
          )
        ],
      ),
      drawer: Drawer(
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
                  title: Text('Вход / Регистрация'),
                  onTap: () => _loginRegister(context),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.widgets,
                color: Colors.lightGreen,
              ),
              title: Text('Каталог и поиск'),
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
                    title: Text('Мои заказы'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyOrdersPage(),
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
              title: Text('Информация'),
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
              title: Text('Обратная связь'),
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
                    title: Text('Выход'),
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
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        cubit: HomeModule.homeBloc(),
        builder: (context, state) {
          if (state is HomeLoading) {
            return LoadingWidget();
          }
          if (state is HomeError) {
            return FaultWidget(message: state.message);
          }
          if (state is HomeReady) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SliderWidget(
                    banners: state.banners,
                  ),
                  ProductSectionWidget(
                    title: "Спецпредложения",
                    products: state.hotDeals,
                  ),
                  CategorySectionWidget(
                    title: "Все коллекции",
                    categories: state.categories,
                  ),
                  ProductSectionWidget(
                    title: "Вкусная цена",
                    products: state.hotProducts,
                  ),
                  ProductSectionWidget(
                    title: "Новинка доставки",
                    products: state.lastProducts,
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
      bottomNavigationBar: BottomAppBarWidget(isHome: true),
    );
  }

  static Route<Object> route() =>
      MaterialPageRoute(builder: (context) => HomePage());

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

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          BlocBuilder(
            builder: _authBlocBuilder,
            cubit: AuthModule.authBloc(),
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle_sharp,
              color: Colors.lightGreen,
            ),
            title: Text('Вход / Регистрация'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                LoginPage.route(
                  loginBloc: AuthModule.loginBloc(),
                  authBloc: AuthModule.authBloc(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.widgets,
              color: Colors.lightGreen,
            ),
            title: Text('Каталог и поиск'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, CategoriesPage.route());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.lightGreen,
            ),
            title: Text('Информация'),
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
            title: Text('Обратная связь'),
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
          _logout()
        ],
      ),
    );
  }

  Widget _authBlocBuilder(BuildContext context, state) {
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
        accountName: Text("${state.user.firstName} ${state.user.lastName}"),
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
  }

  Widget _logout() {
    return BlocBuilder(
      builder: (context, state) {
        return ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.lightGreen,
          ),
          title: Text('Выход'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FeedBack(),
                fullscreenDialog: true,
              ),
            );
          },
        );
      },
    );
  }
}
