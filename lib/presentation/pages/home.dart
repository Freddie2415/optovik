import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/home/home_bloc.dart';
import 'package:optovik/internal/dependencies/home_module.dart';
import 'package:optovik/presentation/pages/categories.dart';
import 'package:optovik/presentation/pages/feedback.dart';
import 'package:optovik/presentation/pages/info.dart';
import 'package:optovik/presentation/pages/login.dart';
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
            DrawerHeader(
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
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
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
      MaterialPageRoute(builder: (context) => const HomePage());
}
