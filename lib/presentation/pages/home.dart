import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optovik/domain/bloc/home/home_bloc.dart';
import 'package:optovik/generated/l10n.dart';
import 'package:optovik/internal/dependencies/home_module.dart';
import 'package:optovik/presentation/pages/categories.dart';
import 'package:optovik/presentation/widgets/bottom_app_bar_widget.dart';
import 'package:optovik/presentation/widgets/category_section_widget.dart';
import 'package:optovik/presentation/widgets/drawer_widget.dart';
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
      drawer: DrawerWidget(),
      body: _body(),
      bottomNavigationBar: BottomAppBarWidget(isHome: true),
    );
  }

  _body() {
    return BlocBuilder<HomeBloc, HomeState>(
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
                  title: S.current.specialOffers,
                  products: state.hotDeals,
                ),
                CategorySectionWidget(
                  title: S.current.allCollections,
                  categories: state.categories,
                ),
                ProductSectionWidget(
                  title: S.current.deliciousPrice,
                  products: state.hotProducts,
                ),
                ProductSectionWidget(
                  title: S.current.newProducts,
                  products: state.lastProducts,
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  static Route<Object> route() =>
      MaterialPageRoute(builder: (context) => HomePage());
}
